""" 
    Modified based on:
    https://github.com/randomcodepanda/Ranger-Linemode/blob/main/mediainfo_linemode.py

    Video information plugin for ranger, requires mediainfo
    Install at ~/.config/ranger/plugins
    Then you can run it with :lineinfo mediainfo
    Or make a keybind for it on the rc.conf, as an example:
    map Mv linemode mediainfo
"""

import datetime
import json
import subprocess

import ranger.api
import ranger.core.linemode


@ranger.api.register_linemode
class MyLinemode(ranger.core.linemode.LinemodeBase):
    """ranger linemode class"""

    name = "mediainfo"

    def filetitle(self, fobj, metadata):
        return fobj.relative_path

    def infostring(self, fobj, metadata):
        key_video = key_audio = None

        def line_output(dict_key, list_fields):
            """Function that formats the final line , used mostly to prettify the output,
            the first argument is the key of the audio/video dictionary from track
            so it creates a new one to be easier to extract the data from fields,
            the second argument is a list of the fields that we want to show or output
            in the line.
            """
            output = []
            new_dict = dict(json_output["media"]["track"][dict_key])
            for value in list_fields:
                if value == "Format":
                    output.append(str(new_dict.get(value, " ")))
                    continue
                if value == "FrameRate":
                    output.append(str(round(float(new_dict.get(value, " ")))) + "FPS")
                    continue
                if value == "SamplingRate":
                    output.append(str(round(float(new_dict.get(value, " ")))) + " kHz")
                    continue
                if value == "Compression_Mode":
                    output.append(str(new_dict.get(value, " ")))
                    continue
                if value == "Height":
                    # Delete the comment of your preferred format (1920x1080 or 1080P)
                    output.append(
                        "%sx%s"
                        % (new_dict.get("Width", " "), new_dict.get("Height", " "))
                    )
                    continue

                output.append(str(new_dict.get(value, "")))

            # Keys in General
            new_dict = dict(json_output["media"]["track"][0])
            # BitRate:
            output.append(
                "%4s" % str(round(int(new_dict.get("OverallBitRate", " ")) / 1000))
                + " kb/s"
            )
            # Duration
            duration = str(new_dict.get("Duration", "0"))
            converted_time = datetime.timedelta(seconds=round(float(duration)))
            output.append(str(converted_time))
            # FileSize:
            size = int(new_dict.get("FileSize", " "))
            for x in ["bytes", "KB", "MB", "GB", "TB"]:
                if size < 1024.0 and size > 1.0:
                    output.append("%7.2f %s" % (size, x))
                size /= 1024.0

            return " ".join(output)

        if not fobj.is_directory:
            try:
                output = subprocess.check_output(
                    ["mediainfo", "--Output=JSON", fobj.path], stderr=subprocess.STDOUT
                ).decode("utf-8")
            # Prevents the crash if Mediainfo doesn't exist or can't be found
            except FileNotFoundError:
                raise NotImplementedError
            # Not sure if this one is needed, i guess it prevents a crash with other errors
            except subprocess.CalledProcessError:
                raise NotImplementedError
            json_output = json.loads(output)
            # Check if the media dictionary is empty, this seems to be needed so it doesn't
            # crash if a file has been deleted under this linemode.
            if json_output["media"] is None:
                raise NotImplementedError
            # Finding the keys for the audio and video dictionaries from the larger track dictionary
            # so we can make smaller dictionaries to make it easier to extract data from fields.
            for key, value in enumerate(json_output["media"]["track"]):
                if value["@type"] == "Video":
                    key_video = key
                elif value["@type"] == "Audio":
                    key_audio = key
            # If there's not a video or audio dictionary we don't want to output anything.
            if not key_video and not key_audio:
                return None
            # This is to output for audio files only, someone might find it useful.
            if key_audio and not key_video:
                return line_output(
                    key_audio, ["Format", "SamplingRate", "Compression_Mode"]
                )
            # List of fields that we want to want to output for video files, the line above
            # is the same for audio files, delete the items you don't want or check the
            # Mediainfo output to add anymore that you want.
            # return line_output(key_video,["OverallBitRate","FrameRate","Format","Height","Duration","FileSize"])
            return line_output(key_video, ["Format", "Height", "FrameRate"])
            # return line_output(key_video,["Height","Duration"])

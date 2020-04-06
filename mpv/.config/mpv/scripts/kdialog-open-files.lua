--
-- Use KDE's KDialog to add files to playlist, subtitles to playing video or open URLs.
-- Based on 'mpv-open-file-dialog'(https://github.com/rossy/mpv-open-file-dialog).
--
-- Default keybindings:
--      Ctrl+f: Add files to the playlist and replace the current playlist.
--      Ctrl+Shift+f: Append files to the playlist.
--      Ctrl+s: Load a subtitle file.
--      Ctrl+u: Load an URL.
--

utils = require 'mp.utils'

function select_files_kdialog()
    local focus = utils.subprocess({
        args = {'xdotool', 'getwindowfocus'}
    })
    
    if mp.get_property("path") == nill then
        directory = ""
    else
        directory = utils.split_path(utils.join_path(mp.get_property("working-directory"), mp.get_property("path")))
    end
        
     file_select = utils.subprocess({
        args = {'kdialog', '--attach='..focus.stdout..'' , '--title=Select Files', '--icon=mpv', '--multiple', '--separate-output', '--getopenfilename', ''..directory..'', 'Multimedia Files (*.3ga *.egp *.3gpp *.3g2 *.3gp2 *.egpp2 *.m4v *.f4v *.mp2 *.mpeg *.vob *.ogv *.mov *.moov *.qtrv *.tv *.rvx *.webm *.flv *.mkv *.wmp *.wmv *.avi *.avf *.divx *.ogm *.mp4 *.aac *.ac3 *.flac *.mp2 *.mp3 *.m4a *.ogg *.oga *.ra *.rax *.webm *.ape *.mka *.m3u *.m3u8 *.vlc *.wma *.opus *.real *.pls *.tta *.wav)'},
        cancellable = false,
    })
end
    
function add_files()
    select_files_kdialog()
    if (file_select.status ~= 0) then return end
    
    local first_file = true
    for filename in string.gmatch(file_select.stdout, '[^\n]+') do
        mp.commandv('loadfile', filename, first_file and 'replace' or 'append')
        first_file = false
    end
end
    
function append_files()
    local playlist_items = 0
    select_files_kdialog()
    if (file_select.status ~= 0) then return end
    
    for filename in string.gmatch(file_select.stdout, '[^\n]+') do
        if (mp.get_property_number("playlist-count") == 0) then
            mp.commandv('loadfile', filename, 'replace')
        else
            mp.commandv('loadfile', filename, 'append')
        end
        playlist_items = playlist_items+1
    end
    mp.osd_message("Added "..playlist_items.." file(s) to playlist")
end


function open_url_kdialog()
    local focus = utils.subprocess({
        args = {'xdotool', 'getwindowfocus'}
    })
    local url_select = utils.subprocess({
        args = {'kdialog', '--attach='..focus.stdout..'' , '--title=Open URL', '--icon=mpv', '--inputbox', 'Enter URL:'},
        cancellable = false,
    })
    
    if (url_select.status ~= 0) then return end
    
    for filename in string.gmatch(url_select.stdout, '[^\n]+') do
        mp.commandv('loadfile', filename, 'replace')
    end
end

function add_sub_kdialog()
    local focus = utils.subprocess({
        args = {'xdotool', 'getwindowfocus'}
    })
    
    if mp.get_property("path") == nill then
		directory = ""
	else
		directory = utils.split_path(utils.join_path(mp.get_property("working-directory"), mp.get_property("path")))
	end
    
    local sub_select = utils.subprocess({
        args = {'kdialog', '--attach='..focus.stdout..'' , '--title=Select Subtitle', ''..directory..'', '--icon=mpv', '--getopenfilename', 'Subtitle Files (*.srt *.sub *.ass *.ssa *.mplsub *.txt)'},
        cancellable = false,
    })
    
    if (sub_select.status ~= 0) then return end
    
    for filename in string.gmatch(sub_select.stdout, '[^\n]+') do
        mp.commandv('sub-add', filename, 'select')
    end
end

mp.add_key_binding("Ctrl+f", "add-files-kdialog", add_files)
mp.add_key_binding("Ctrl+Shift+f", "append-files-kdialog", append_files)
mp.add_key_binding("Ctrl+u", "open-url-kdialog", open_url_kdialog)
mp.add_key_binding("Ctrl+s", "add-subtitle-kdialog", add_sub_kdialog)

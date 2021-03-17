require 'os'
require 'io'
require 'string'

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return string.sub(s, 0, -2) -- Trim the trailing newline
end

currently_played_file = ""

function delete_current_file()
  currently_played_file = mp.get_property("path")
  os.execute("rm '" .. currently_played_file .. "'")
  mp.commandv("show-text", "Deleted", 2000)
  mp.commandv("playlist-next", "weak")
end

mp.add_forced_key_binding("shift+DEL", "delete_current_file", delete_current_file)

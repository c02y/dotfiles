local utils = require "mp.utils"

local function getName()
    local playlist = mp.get_property_native('playlist')
    local dt = {}
    for i = 1, #playlist do
        table.insert(dt, {filename = playlist[i].filename, data = playlist[i].filename:lower()})
    end
    return dt
end

local function getDate()
    local playlist = mp.get_property_native('playlist')
    local dt = {}
    for i = 1, #playlist do
        local data = nil
        local fi = utils.file_info(playlist[i].filename)
        if(fi == nil) then data = 0 else data = fi.mtime end
        table.insert(dt, {filename = playlist[i].filename, data = data})
    end
    return dt
end

local function getSize()
    local playlist = mp.get_property_native('playlist')
    local dt = {}
    for i = 1, #playlist do
        local data = nil
        local fi = utils.file_info(playlist[i].filename)
        if(fi == nil) then data = 0 else data = fi.size end
        table.insert(dt,  {filename = playlist[i].filename, data = data})
    end
    return dt
end

local function sort(dt,asc)
    if(asc == nil or asc == "asc" or asc == "") then 
        table.sort(dt, function(a, b) return a.data < b.data end)
    else
        table.sort(dt, function(a, b) return a.data > b.data end)
    end
end

local function main(type,asc)
    local dt = nil
    if(type == nil) then type = "name" end
    if(asc == nil) then asc = "asc" end

    if(type == "date") then 
        dt = getDate()
    elseif(type == "size") then 
        dt = getSize()
    else 
        dt = getName() 
    end
    sort(dt,asc)
    mp.commandv('playlist-clear')
    for i,n in ipairs(dt) do 
        if(i == 1) then
            mp.commandv('loadfile',n.filename,'replace')     
        else
            mp.commandv('loadfile',n.filename,'append')
        end
    end
    mp.osd_message("Playlist Sort: "..type.." "..asc)
end

mp.register_script_message("playlist-sort", main)

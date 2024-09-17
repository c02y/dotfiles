---Launch a dialog for opening files or URLs (Zenity)
---@author ObserverOfTime
---@license 0BSD

local utils = require 'mp.utils'

local MULTIMEDIA = table.concat({
    '*.aac',
    '*.avi',
    '*.flac',
    '*.flv',
    '*.m3u',
    '*.m3u8',
    '*.m4v',
    '*.mkv',
    '*.mov',
    '*.mp3',
    '*.mp4',
    '*.mpeg',
    '*.mpg',
    '*.oga',
    '*.ogg',
    '*.ogv',
    '*.opus',
    '*.wav',
    '*.webm',
    '*.wmv',
}, ' ')

local SUBTITLES = table.concat({
    '*.ass',
    '*.srt',
    '*.ssa',
    '*.sub',
    '*.txt',
}, ' ')

local ICON = '/usr/share/icons/hicolor/16x16/apps/mpv.png'

---@vararg table
local function merge(...)
    local ret = {}
    for _, t in pairs({...}) do
        for _, v in pairs(t) do
            table.insert(ret, v)
        end
    end
    return ret
end

---@class ZOpts
---@field title string
---@field text string[]
---@field default? string[]
---@field type? string[]
---@field args string[]

---@param opts ZOpts
---@return fun()
local function Zenity(opts)
    return function()
        local path = mp.get_property('path')
        path = path == nil and {} or {
            '--filename', utils.split_path(
                utils.join_path(utils.getcwd(), path)
            )
        }
        local ontop = mp.get_property_native('ontop')
        local focus = utils.subprocess {
            args = {'xdotool', 'getwindowfocus'}
        }.stdout:gsub('\n$', '')
        mp.set_property_native('ontop', false)
        local zenity = utils.subprocess {
            args = merge({
                'zenity', '--modal',
                '--title', opts.title,
                '--attach', focus,
                '--window-icon', ICON,
            }, opts.default or path,
            opts.text, opts.type or {
                '--file-selection',
                '--separator', '\n',
                '--multiple',
            }), cancellable = false,
        }
        mp.set_property_native('ontop', ontop)
        if zenity.status ~= 0 then return end
        for file in zenity.stdout:gmatch('[^\n]+') do
            mp.commandv(opts.args[1], file, opts.args[2])
        end
    end
end

mp.add_key_binding('Ctrl+f', 'open-files', Zenity {
    title = 'Select Files',
    text = {'--file-filter', 'Multimedia Files | '..MULTIMEDIA},
    args = {'loadfile', 'append-play'},
})
mp.add_key_binding('Ctrl+F', 'open-url', Zenity {
    title = 'Open URL',
    text = {'--text', 'Enter the URL to open:'},
    default = {},
    type = {'--entry'},
    args = {'loadfile', 'replace'},
})
mp.add_key_binding('Alt+f', 'open-subs', Zenity {
    title = 'Select Subs',
    text = {'--file-filter', 'Subtitle Files | '..SUBTITLES},
    args = {'sub-add', 'select'},
})

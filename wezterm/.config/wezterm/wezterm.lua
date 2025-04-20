-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This will hold the configuration
local config = {}

-------------------
-- Put config below
--
-- NOTE: Ctrl+Shift+L, then `window:effective_config()` to show all config values
-- or `window:effective_config()["enable_wayland"]` to show the specific value
config.window_background_opacity = 0.8
-- color_scheme: https://wezfurlong.org/wezterm/colorschemes
config.color_scheme = "Seti" -- Wez, Thayer Bright, Seti
-- `wezterm ls-fonts --list-system` to list all available fonts for config file
-- `wezterm ls-fonts` to explain which font it will use for the different text styles.
config.font = wezterm.font_with_fallback({ "OperatorMono Nerd Font Mono", "Noto Sans CJK SC" })
config.font_size = 14 -- Ctrl--/+ to resize font size, Ctrl-0 to reset font to this size
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.default_prog = { "fish" }
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.use_resize_increments = true
config.check_for_updates = false
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.disable_default_quick_select_patterns = true
config.quick_select_patterns = {
	"https?://[^\"' ]+",                            -- url
	"sha256-\\S{44}",                               -- sha256 another
	"[0-9a-f]{7,40}",                               -- sha1
	"sha256:[A-Za-z0-9]{52}",                       -- sha256
	"[a-z0-9-]+.[a-z0-9]+.[a-z0-9]+.[a-z0-9]+ ",    -- inno FQDN
	"[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9.-]+", -- simple e-mail
	"'(\\S[^']*\\S)'",                              -- single quoted text
	'"(\\S[^"]*\\S)"',                              -- double quoted text
	"~?/?[a-zA-Z0-9_/.-]+",                         -- path
	"~> (.*)",                                      -- stuff after ~> because that is the prompt
	"%s(.*)%s",                                     -- anything else covered with whitespace
}

-- TODO: https://wezfurlong.org/wezterm/config/key-tables.html
-- Show which key table is active in the status area
-- wezterm.on("update-right-status", function(window, pane)
-- 	local name = window:active_key_table()
-- 	if name then
-- 		name = "TABLE: " .. name
-- 	end
-- 	window:set_right_status(name or "")
-- end)
-- https://wezfurlong.org/wezterm/config/keys.html
-- `wezterm show-keys` to list all keys
config.keys = {
	{ mods = "ALT",        key = "Enter", action = "DisableDefaultAssignment" },
	-- NOTE: if characters are typed in UPPER case, it will auto paste the selection
	{ mods = "CTRL|SHIFT", key = "p",     action = "QuickSelect" },
}

-------------------
-- Put config above
return config

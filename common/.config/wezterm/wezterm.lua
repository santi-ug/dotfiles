local wezterm = require("wezterm")
local config = {}
-----------------------------------------------------------
-- FONT (Cascadia Mono Nerd Font, smaller, tighter lines)
-----------------------------------------------------------
config.font = wezterm.font("CaskaydiaMono Nerd Font Mono")
config.font_size = 11.0 -- Smaller (adjust if needed)
config.line_height = 1.05 -- Prevents tall text
-----------------------------------------------------------
-- KEYBOARD (enable extended keys for Ctrl+Tab, etc.)
-----------------------------------------------------------
config.enable_kitty_keyboard = true
-----------------------------------------------------------
-- TOKYONIGHT GRAY (desaturated, minimal, dark)
-----------------------------------------------------------
config.colors = {
	foreground = "#C0C0C5",
	background = "#1A1A1E",
	cursor_bg = "#C0C0C5",
	cursor_fg = "#1A1A1E",
	cursor_border = "#C0C0C5",
	selection_bg = "#2C2C33",
	selection_fg = "#C0C0C5",
	ansi = {
		"#1A1A1E", -- black
		"#C74F4F", -- red (muted)
		"#8FBF7F", -- green (muted)
		"#E6C384", -- yellow (desaturated gold)
		"#7A8190", -- blue-gray (desaturated)
		"#967BB6", -- purple-gray
		"#7EBCC2", -- cyan muted
		"#C0C0C5", -- white (soft)
	},
	brights = {
		"#2A2A2F", -- black bright
		"#D47777", -- red
		"#A8D0A0", -- green
		"#EAD29A", -- yellow
		"#8F93A2", -- blue-gray brighter
		"#A98FC6", -- purple-gray brighter
		"#95D2D7", -- cyan
		"#E4E4E8", -- white bright
	},
}
-----------------------------------------------------------
-- WINDOW + UI BEHAVIOR
-----------------------------------------------------------
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 8,
	top = 6,
	bottom = 6,
}
config.unix_domains = {}
config.default_gui_startup_args = { "start", "--no-auto-connect" }

config.keys = {
	-- Disable WezTerm's default Ctrl+Tab behavior
	{ key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
}

return config

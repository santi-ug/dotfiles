local wezterm = require("wezterm")

-- Build config the "new" recommended way if available
local config = wezterm.config_builder and wezterm.config_builder() or {}

-----------------------------------------------------------
-- FONT (Cascadia Mono Nerd Font, smaller, tighter lines)
-----------------------------------------------------------
config.font = wezterm.font("CaskaydiaMono Nerd Font Mono")
config.font_size = 11.0
config.line_height = 1.05

-----------------------------------------------------------
-- KEYBOARD
-----------------------------------------------------------
config.term = "xterm-256color"
config.enable_kitty_keyboard = false

-----------------------------------------------------------
-- TOKYONIGHT GRAY (desaturated, minimal, dark)
-----------------------------------------------------------
config.colors = {
	foreground = "#C0C0C5",
	background = "#1A1A1B",
	cursor_bg = "#C0C0C5",
	cursor_fg = "#1A1A1E",
	cursor_border = "#C0C0C5",
	selection_bg = "#2C2C33",
	selection_fg = "#C0C0C5",
	ansi = {
		"#1A1A1E",
		"#C74F4F",
		"#8FBF7F",
		"#E6C384",
		"#7A8190",
		"#967BB6",
		"#7EBCC2",
		"#C0C0C5",
	},
	brights = {
		"#2A2A2F",
		"#D47777",
		"#A8D0A0",
		"#EAD29A",
		"#8F93A2",
		"#A98FC6",
		"#95D2D7",
		"#E4E4E8",
	},
}

-----------------------------------------------------------
-- WINDOW + UI BEHAVIOR
-----------------------------------------------------------
config.hide_tab_bar_if_only_one_tab = true

-- IMPORTANT:
-- "NONE" removes the native titlebar and usually makes resizing annoying/impossible on macOS.
-- Use RESIZE so you can still resize the window.
config.window_decorations = "RESIZE"

config.window_padding = {
	left = 6,
	right = 6,
	top = 6,
	bottom = 6,
}

-- Default size on open (bigger): rows/cols, not pixels
config.initial_rows = 50
config.initial_cols = 180

-- Keep your startup args
config.unix_domains = {}
config.default_gui_startup_args = { "start", "--no-auto-connect" }
config.window_close_confirmation = "NeverPrompt"

-----------------------------------------------------------
-- Center window on startup (macOS)
-----------------------------------------------------------
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui = window:gui_window()

	-- Center on main screen using pixel dimensions
	local screen = wezterm.gui.screens().main
	local win_dims = gui:get_dimensions()

	local x = math.floor((screen.width - win_dims.pixel_width) / 2)
	local y = math.floor((screen.height - win_dims.pixel_height) / 2)

	gui:set_position(x, y)
end)

-----------------------------------------------------------
-- KEYS
-----------------------------------------------------------
config.keys = {
	-- Disable WezTerm's default Ctrl+Tab behavior
	{ key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
}

return config

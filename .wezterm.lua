-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "catppuccin-mocha"
config.default_prog = { "wsl", "--cd", "~" }
config.font = wezterm.font("BlexMono Nerd Font")
config.font_size = 8.5
config.hide_tab_bar_if_only_one_tab = true
config.background = {
	{
		source = {
			File = "C:/Users/Yara/Pictures/Wallpaper/study club.jpeg",
		},
		hsb = { brightness = 0.02 },
	},
}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config

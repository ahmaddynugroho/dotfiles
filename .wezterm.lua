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

-- https://github.com/wez/wezterm/discussions/4728
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Poimandres"
config.font = wezterm.font("FiraCode Nerd Font")
config.hide_tab_bar_if_only_one_tab = true
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

if is_windows then
	config.font_size = 8.5
	config.default_prog = { "wsl", "--cd", "~" }
	config.background = {
		{
			source = {
				File = "C:/Users/Yara/Pictures/Wallpaper/study club.jpeg",
			},
			hsb = { brightness = 0.02 },
		},
	}
end

if is_linux then
	config.font_size = 13
	config.background = {
		{
			source = {
				File = "/home/miku4j/Pictures/arius.png",
			},
			hsb = { brightness = 0.015 },
		},
	}
end

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config

-- Initialize Configuration
local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()
local opacity = 0.75
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

-- Font
config.font = wezterm.font_with_fallback({
	{
		family = "FiraCode Nerd Font",
		weight = "Regular",
	},
	"Segoe UI Emoji",
})
config.font_size = 12

-- Set the color scheme
config.color_scheme = "Catppuccin Mocha"

-- Access the color scheme's colors
local color_schemes = wezterm.color.get_builtin_schemes()
local colors = color_schemes["Catppuccin Mocha"]

-- Window
config.initial_rows = 45
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Colors
config.force_reverse_video_cursor = true

-- Shell
config.default_prog = { "wsl.exe" }

-- Tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = true
-- Set tab bar colors
config.colors = {
	tab_bar = {
		background = transparent_bg,
		new_tab = { fg_color = colors.background, bg_color = colors.brights[6] },
		new_tab_hover = { fg_color = colors.background, bg_color = colors.foreground },
	},
}

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = config.colors.brights[1]
	local foreground = config.colors.foreground

	if tab.is_active then
		background = config.colors.brights[7]
		foreground = config.colors.background
	elseif hover then
		background = config.colors.brights[8]
		foreground = config.colors.background
	end

	local title = string.format(" %d: %s ", tab.tab_index + 1, tab.active_pane.title)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)

-- Keybindings
config.keys = {
	-- Remap paste for clipboard history compatibility
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "t", -- Press Ctrl+t to open a new tab
		mods = "CTRL",
		action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
	},
	{
		key = "1",
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = 0 }), -- Tabs are 0-indexed
	},
	-- Switch to tab 2 with Ctrl+2
	{
		key = "2",
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = 1 }),
	},
	-- Switch to tab 3 with Ctrl+3
	{
		key = "3",
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = 2 }),
	},
	-- Switch to tab 4 with Ctrl+4
	{
		key = "4",
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = 3 }),
	},
	-- Switch to tab 5 with Ctrl+5
	{
		key = "5",
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = 4 }),
	},
}

config.default_domain = "WSL:Ubuntu"

return config

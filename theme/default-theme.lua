local filesystem = require("gears.filesystem")
local mat_colors = require("theme.mat-colors")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local theme = {}
local mono_font = "Jetbrains Mono Bold 9"
-- local serif_font = 'SF Pro Display 9'
local serif_font = mono_font
-- local symbol_font = 'Font Awesome 5 Pro Regular 9'
local symbol_font = mono_font
theme.icons = theme_dir .. "/icons/"
theme.font = serif_font

-- Colors Pallets

-- Primary
theme.primary = mat_colors.hue_green

-- Accent
theme.accent = mat_colors.orange

-- Background
theme.background = mat_colors.background
theme.panel_background = theme.background.hue_800 .. "AA"
local transparent = "#00000000"

local awesome_overrides = function(overrided_theme)
	overrided_theme.dir = os.getenv("HOME") .. "/.config/awesome/theme"
	overrided_theme.icons = overrided_theme.dir .. "/icons/"
	overrided_theme.wallpaper = "#e0e0e0"
	overrided_theme.font = serif_font
	overrided_theme.title_font = serif_font

	overrided_theme.fg_normal = "#ffffffde"

	overrided_theme.fg_focus = "#e4e4e4"
	overrided_theme.fg_urgent = "#CC9393"
	overrided_theme.bat_fg_critical = "#232323"

	overrided_theme.bg_normal = overrided_theme.panel_background
	overrided_theme.bg_focus = "#5a5a5a"
	overrided_theme.bg_urgent = "#3F3F3F"
	overrided_theme.bg_systray = overrided_theme.background.hue_800

	-- Borders

	overrided_theme.border_width = dpi(1)
	overrided_theme.border_focus = overrided_theme.primary.hue_300 .. "44"
	overrided_theme.border_normal = overrided_theme.background.hue_700 .. "AA"
	overrided_theme.border_marked = "#CC9393"

	-- Menu

	overrided_theme.menu_height = dpi(16)
	overrided_theme.menu_width = dpi(160)

	-- Tooltips
	overrided_theme.tooltip_bg = "#232323"
	-- theme.tooltip_border_color = '#232323'
	overrided_theme.tooltip_border_width = 0
	overrided_theme.tooltip_shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, dpi(3))
	end

	-- Layout

	overrided_theme.layout_max = overrided_theme.icons .. "layouts/max.png"
	overrided_theme.layout_tile = overrided_theme.icons .. "layouts/tile.png"
	overrided_theme.layout_tileleft = overrided_theme.icons .. "layouts/tileleft.png"
	overrided_theme.layout_tiletop = overrided_theme.icons .. "layouts/tiletop.png"
	overrided_theme.layout_tilebottom = overrided_theme.icons .. "layouts/tilebottom.png"
	overrided_theme.layout_floating = overrided_theme.icons .. "layouts/floating.png"
	overrided_theme.layout_cornernw = overrided_theme.icons .. "layouts/cornernw.png"

	-- Taglist

	overrided_theme.taglist_font = symbol_font
	overrided_theme.taglist_bg_empty = transparent
	overrided_theme.taglist_bg_occupied = transparent
	overrided_theme.taglist_bg_urgent = {
		type = "linear",
		from = { 0, 0 },
		to = { 0, dpi(40) },
		stops = {
			{ 0, overrided_theme.accent.hue_600 },
			{ 0.07, overrided_theme.accent.hue_600 },
			{ 0.08, overrided_theme.background.hue_600 .. "66" },
			{ 0.95, overrided_theme.accent.hue_300 .. "FF" },
		},
	}
	overrided_theme.taglist_bg_focus = {
		type = "linear",
		from = { 0, 0 },
		to = { 0, dpi(40) },
		stops = {
			{ 0, overrided_theme.accent.hue_600 },
			{ 0.07, overrided_theme.accent.hue_600 },
			{ 0.08, overrided_theme.background.hue_600 .. "66" },
			{ 0.95, overrided_theme.background.hue_600 .. "FF" },
		},
	}
	-- Tasklist

	overrided_theme.tasklist_font = mono_font
	overrided_theme.tasklist_bg_normal = transparent
	overrided_theme.tasklist_bg_focus = {
		type = "linear",
		from = { 0, 0 },
		to = { 0, dpi(40) },
		stops = {
			{ 0, overrided_theme.primary.hue_400 },
			{ 0.07, overrided_theme.primary.hue_400 },
			{ 0.08, overrided_theme.background.hue_600 .. "66" },
			{ 0.95, overrided_theme.background.hue_600 .. "FF" },
		},
	}
	overrided_theme.tasklist_bg_urgent = overrided_theme.primary.hue_800
	overrided_theme.tasklist_fg_focus = "#DDDDDD"
	overrided_theme.tasklist_fg_urgent = overrided_theme.fg_normal
	overrided_theme.tasklist_fg_normal = "#AAAAAA"

	overrided_theme.icon_theme = "Papirus-Dark"
end
return { theme = theme, awesome_overrides = awesome_overrides }

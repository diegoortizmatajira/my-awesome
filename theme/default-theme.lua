local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local theme = {}
local mono_font = 'Jetbrains Mono Bold 9'
-- local serif_font = 'SF Pro Display 9'
local serif_font = mono_font
-- local symbol_font = 'Font Awesome 5 Pro Regular 9'
local symbol_font = mono_font
theme.icons = theme_dir .. '/icons/'
theme.font = serif_font

-- Colors Pallets

-- Primary
theme.primary = mat_colors.lime

-- Accent
theme.accent = mat_colors.orange

-- Background
theme.background = mat_colors.background

local awesome_overrides = function(theme)
  theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
  theme.icons = theme.dir .. '/icons/'
  theme.wallpaper = '#e0e0e0'
  theme.font = serif_font
  theme.title_font = serif_font

  theme.fg_normal = '#ffffffde'

  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.background.hue_800
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.background.hue_800

  -- Borders

  theme.border_width = dpi(2)
  theme.border_normal = theme.background.hue_800
  theme.border_focus = theme.primary.hue_300
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = dpi(16)
  theme.menu_width = dpi(160)

  -- Tooltips
  theme.tooltip_bg = '#232323'
  -- theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(3))
  end

  -- Layout

  theme.layout_max = theme.icons .. 'layouts/max.png'
  theme.layout_tile = theme.icons .. 'layouts/tile.png'
  theme.layout_tilebottom = theme.icons .. 'layouts/tilebottom.png'
  theme.layout_floating = theme.icons .. 'layouts/floating.png'
  theme.layout_cornernw = theme.icons .. 'layouts/cornernw.png'

  -- Taglist

  theme.taglist_font = symbol_font
  theme.taglist_bg_empty = theme.background.hue_800
  theme.taglist_bg_occupied = theme.background.hue_800
  theme.taglist_bg_urgent = {
    type = 'linear',
    from = {0, 0},
    to = {0, dpi(40)},
    stops = {
      {0, theme.accent.hue_800},
      {0.07, theme.accent.hue_800},
      {0.08, theme.background.hue_800},
      {0.95, theme.accent.hue_300}
    }
  }
  theme.taglist_bg_focus = {
    type = 'linear',
    from = {0, 0},
    to = {0, dpi(40)},
    stops = {
      {0, theme.accent.hue_800},
      {0.07, theme.accent.hue_800},
      {0.08, theme.background.hue_800},
      {0.95, theme.background.hue_600}
    }
  }
  -- Tasklist

  theme.tasklist_font = mono_font
  theme.tasklist_bg_normal = theme.background.hue_800
  theme.tasklist_bg_focus = {
    type = 'linear',
    from = {0, 0},
    to = {0, dpi(40)},
    stops = {
      {0, theme.primary.hue_800},
      {0.07, theme.primary.hue_800},
      {0.08, theme.background.hue_800},
      {0.95, theme.background.hue_600}
    }
  }
  theme.tasklist_bg_urgent = theme.primary.hue_800
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'

  theme.icon_theme = 'Papirus-Dark'

  -- Client
  theme.border_width = dpi(2)
  theme.border_focus = theme.primary.hue_500
  theme.border_normal = theme.background.hue_800
end
return {theme = theme, awesome_overrides = awesome_overrides}

local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'SF Pro Display 9'

-- Colors Pallets

-- Primary
-- Accent
-- Background

local awesome_overrides = function(theme)
    --
end
return {
    theme = theme,
    awesome_overrides = awesome_overrides
}

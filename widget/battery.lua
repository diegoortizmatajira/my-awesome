local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local wibox = require('wibox')
local mat_colors = require('theme.mat-colors')

local function Battery(_, color)
  return {
    {
      batteryarc_widget({
        show_current_level = true,
        arc_thickness = 2,
        main_color = color.hue_500,
        charging_color = mat_colors.hue_green.hue_A200,
        medium_level_color = mat_colors.orange.hue_500,
        low_level_color = mat_colors.red.hue_700,
        bg_color = color.hue_900
      }),
      layout = wibox.layout.fixed.horizontal
    },
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end

return Battery

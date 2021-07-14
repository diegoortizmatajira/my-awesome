local font_icons = require('layout.font-icons')
local wibox = require('wibox')
local awful = require('awful')

local function Power(_, color)
  local power_widget = font_icons.make_faicon(font_icons.power, color.hue_500)
  power_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.spawn('custom-askpoweroptions') end
  end)
  return {{power_widget, layout = wibox.layout.fixed.horizontal}, left = 2, right = 2, widget = wibox.container.margin}
end

return Power

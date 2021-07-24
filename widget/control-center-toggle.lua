local awful = require('awful')
local font_icons = require('widget.font-icons')
local wibox = require('wibox')

local function control_center_toggle(_, color)
  local toggler = font_icons.make_faicon(font_icons.notification, color.hue_500)
  toggler:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.screen.focused().control_center:toggle() end
  end)
  return {{toggler, layout = wibox.layout.fixed.horizontal}, left = 5, right = 5, widget = wibox.container.margin}
end

return control_center_toggle

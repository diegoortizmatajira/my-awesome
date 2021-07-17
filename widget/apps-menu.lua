local awful = require('awful')
local font_icons = require('widget.font-icons')

local function AppMenu(_, color)
  local app_menu = font_icons.make_faicon(font_icons.home, color.hue_500, 8)
  app_menu:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.spawn('custom-launcher') end
  end)
  return app_menu
end

return AppMenu

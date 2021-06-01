local awful = require('awful')
local font_icons = require('layout.font-icons')

local function AppMenu(s, color)
    local app_menu = font_icons.make_faicon(font_icons.home, color, 8)
    app_menu:connect_signal("button::press", function(_, _, _, button) if (button == 1) then
        awful.spawn('custom-launcher')
    end end)
    return app_menu
end

return AppMenu

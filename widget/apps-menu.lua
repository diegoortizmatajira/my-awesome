local awful = require('awful')
local font_icons = require('widget.font-icons')
local clickable_container = require('widget.material.clickable-container')

local function AppMenu(_, color)
    local layoutBox = clickable_container(font_icons.make_faicon(font_icons.home, color.hue_500, 8))
    layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function()
        awful.spawn('custom-launcher')
    end)))
    return layoutBox
end

return AppMenu

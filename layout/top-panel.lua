local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local TagList = require('widget.tag-list')
local AppsMenu = require('widget.apps-menu')
local Keyboard = require('widget.keyboard')
local Audio = require('widget.audio')
local Clock = require('widget.clock')
local Wifi = require('widget.wifi')
local Network = require('widget.network')
local Vpn = require('widget.vpn')
local Battery = require('widget.battery')
local Power = require('widget.power')
local Systray = require('widget.systray')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')
local mat_colors = require('theme.mat-colors')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
    awful.spawn(awful.screen.focused().selected_tag.defaultApp, {tag = _G.mouse.screen.selected_tag, placement = awful.placement.bottom_right})
end)))

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
    local layoutBox = clickable_container(awful.widget.layoutbox(s))
    layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))
    return layoutBox
end

local TopPanel = function(s)

    local panel = wibox({
        ontop = true,
        screen = s,
        height = dpi(32),
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        bg = beautiful.background.hue_800,
        fg = beautiful.fg_normal,
        struts = {top = dpi(32)}
    })

    panel:struts({top = dpi(32)})

    panel:setup{
        layout = wibox.layout.align.horizontal,
        -- expand = "none",
        {layout = wibox.layout.fixed.horizontal,
            AppsMenu(s, mat_colors.hue_green.hue_500),
            TagList(s, mat_colors.blue.hue_500),
            LayoutBox(s),
        },
        {
            TaskList(s),
            layout = wibox.layout.align.horizontal},
        {
            layout = wibox.layout.fixed.horizontal,
            Keyboard(s, mat_colors.cyan),
            Audio(s, mat_colors.hue_blue),
            Wifi(s, mat_colors.blue),
            Network(s, mat_colors.indigo),
            Vpn(s, mat_colors.hue_purple),
            Battery(s, mat_colors.purple),
            Clock(s, mat_colors.pink),
            Power(s, mat_colors.red),
            Systray(mat_colors.brown),
        }
    }

    return panel
end

return TopPanel

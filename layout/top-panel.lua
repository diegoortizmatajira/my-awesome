local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local TagList = require('widget.tag-list')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')
local mat_colors = require('theme.mat-colors')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local font_icons = require('layout.font-icons')

-- Titus - Horizontal Tray
local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(20)
systray.forced_height = 20

-- Clock / Calendar 24h format
-- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n     %H:%M</span>')
-- Clock / Calendar 12AM/PM fornat
local textclock = wibox.widget.textclock('%a %I:%M %p')

-- textclock.forced_height = 36

-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month({
    screen = s,
    start_sunday = false,
    week_numbers = true
})
month_calendar:attach(textclock)

local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn(
                    awful.screen.focused().selected_tag.defaultApp,
                    {
                        tag = _G.mouse.screen.selected_tag,
                        placement = awful.placement.bottom_right
                    }
                )
            end
        )
    )
)

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
    local layoutBox = clickable_container(awful.widget.layoutbox(s))
    layoutBox:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    return layoutBox
end

local TagListComponent = function(s)
    return {
        {
            font_icons.make_faicon(font_icons.tag_opening, mat_colors.blue.hue_500),
            TagList(s, font_icons.make_icon(font_icons.tag_separator, mat_colors.blue.hue_500)),
            font_icons.make_faicon(font_icons.tag_closing, mat_colors.blue.hue_500),
            layout = wibox.layout.fixed.horizontal
        },
        left  = 2,
        right = 2,
        widget = wibox.container.margin
    }
end

local ClockComponent =  {
    {
        font_icons.make_faicon(font_icons.icon_clock, mat_colors.pink.hue_500),
        clock_widget,
        layout = wibox.layout.fixed.horizontal
    },
    left  = 2,
    right = 2,
    widget = wibox.container.margin
}

local AudioComponent = {
    {
        font_icons.make_faicon(font_icons.sound_on, mat_colors.hue_blue.hue_500),
        layout = wibox.layout.fixed.horizontal
    },
    left  = 2,
    right = 2,
    widget = wibox.container.margin
}

local TitleComponent = {
    {
        font_icons.make_faicon(font_icons.icon_window, mat_colors.hue_green.hue_500),
        -- { -- Title
        --     align  = 'center',
        --     widget = awful.titlebar.widget.titlewidget(c)
        -- },
        layout = wibox.layout.fixed.horizontal
    },
    left  = 2,
    right = 2,
    widget = wibox.container.margin
}

local TopPanel = function(s)

    local panel =
        wibox(
            {
                ontop = true,
                screen = s,
                height = dpi(32),
                width = s.geometry.width,
                x = s.geometry.x,
                y = s.geometry.y,
                stretch = false,
                bg = beautiful.background.hue_800,
                fg = beautiful.fg_normal,
                struts = {
                    top = dpi(32)
                }
            }
        )

    panel:struts(
        {
            top = dpi(32)
        }
    )

    panel:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            TagListComponent(s),
            -- font_icons.make_faicon(font_icons.icon_arrow_square_right, mat_colors.hue_green.hue_500),
            TaskList(s),
        },
        {
            layout = wibox.layout.align.horizontal,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            LayoutBox(s),

            font_icons.make_faicon(font_icons.keyboard, mat_colors.teal.hue_500),
            AudioComponent,
            font_icons.make_faicon(font_icons.wifi, mat_colors.blue.hue_500),
            font_icons.make_faicon(font_icons.network, mat_colors.indigo.hue_500),
            font_icons.make_faicon(font_icons.vpn, mat_colors.hue_purple.hue_500),
            font_icons.make_faicon(font_icons.battery, mat_colors.purple.hue_500),
            ClockComponent,
            font_icons.make_faicon(font_icons.power, mat_colors.red.hue_500),
            wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3)),
        }
    }

    return panel
end

return TopPanel

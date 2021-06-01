local font_icons = require('layout.font-icons')
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
local wibox = require('wibox')

local function Audio(s, color)
    -- Clock / Calendar 24h format
    -- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n     %H:%M</span>')
    -- Clock / Calendar 12AM/PM fornat
    local textclock = wibox.widget.textclock(string.format([[<span color='%s'>%s</span>]], color.hue_100, '%a %I:%M %p'))

    -- Add a calendar (credits to kylekewley for the original code)
    local month_calendar = awful.widget.calendar_popup.month({screen = s, start_sunday = false, week_numbers = true})

    local clock_widget = wibox.widget {
        {
            font_icons.make_faicon(font_icons.icon_clock, color.hue_500), 
            wibox.container.margin(textclock, dpi(3), dpi(3), dpi(3), dpi(3)), 
            layout = wibox.layout.fixed.horizontal
        },
        left = 5,
        right = 5,
        widget = wibox.container.margin
    }


    month_calendar:attach(clock_widget)


    return clock_widget
end

return Audio

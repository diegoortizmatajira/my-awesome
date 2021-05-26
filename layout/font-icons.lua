local wibox = require('wibox')
local icon_font = 'Font Awesome 5 Pro Regular 12'

local make_icon = function (code, color)
    return {
        markup = '<span color=\''..color ..'\'>'..code..'</span>',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
end

local make_faicon = function (code, color)
    return {
        {
            markup = '<span color=\''..color ..'\'>'..code..'</span>',
            align  = 'center',
            valign = 'center',
            widget = wibox.widget.textbox,
            font = icon_font
        },
        left  = 3,
        right = 3,
        widget = wibox.container.margin
    }
end

return {
    tag_opening = '\u{f104}',
    tag_closing = '\u{f105}',
    tag_separator = '|',
    icon_clock = '\u{f017}',
    icon_window = '\u{f40e}',
    icon_arrow_square_right = '\u{f33b}',
    make_faicon = make_faicon,
    make_icon = make_icon,
}

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
    local faicon = make_icon(code, color)
    faicon.font = icon_font
    return faicon
end

return {
    tag_opening = '\u{f104}',
    tag_closing = '\u{f105}',
    tag_separator = '|',
    make_faicon = make_faicon,
    make_icon = make_icon,
}

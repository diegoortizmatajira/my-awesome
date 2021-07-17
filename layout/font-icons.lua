local wibox = require('wibox')
local icon_font = 'Font Awesome 5 Pro Regular 12'

local make_icon = function(code, color)
  return wibox.widget{
    {
      markup = string.format([[<span color='%s'>%s</span>]], color, code),
      align = 'center',
      valign = 'center',
      widget = wibox.widget.textbox
    },
    widget = wibox.container.background
  }
end

local make_faicon = function(code, color, margin)
  if margin == nil then margin = 3 end
  local icon_widget = wibox.widget{
    markup = string.format([[<span color='%s'>%s</span>]], color, code),
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
    font = icon_font
  }
  local result = wibox.widget{icon_widget, left = margin, right = margin, widget = wibox.container.margin}
  result.change_icon = function(new_code)
    icon_widget.markup = string.format([[<span color='%s'>%s</span>]], color, new_code)
  end
  return result
end

return {
  tag_opening = '\u{f104}',
  tag_closing = '\u{f105}',
  tag_separator = '\u{007C}',
  icon_clock = '\u{f017}',
  icon_window = '\u{f40e}',
  icon_arrow_square_right = '\u{f33b}',
  sound_on = '\u{f028}',
  sound_off = '\u{f2e2}',
  network = '\u{f6ff}',
  wifi = '\u{f1eb}',
  keyboard = '\u{f11c}',
  vpn = '\u{f57d}',
  battery = '\u{f240}',
  power = '\u{f011}',
  search = '\u{f002}',
  home = '\u{f015}',
  windows = '\u{f17a}',
  hamburguer = '\u{f0c9}',
  collapse = '\u{f101}',
  expand = '\u{f100}',
  toggle = '\u{f3f2}',
  terminal = '\u{f120}',
  browser = '\u{f267}',
  make_faicon = make_faicon,
  make_icon = make_icon
}

local font_icons = require('layout.font-icons')
local wibox = require('wibox')
local awful = require('awful')

local function Keyboard(s, color)
  return {
    {
      font_icons.make_faicon(font_icons.keyboard, color.hue_500),
      {{widget = awful.widget.keyboardlayout}, fg = color.hue_100, widget = wibox.container.background},
      layout = wibox.layout.fixed.horizontal
    },
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end

return Keyboard

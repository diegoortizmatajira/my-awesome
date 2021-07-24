local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local font_icons = require('widget.font-icons')
local dpi = require('beautiful').xresources.apply_dpi

local function Systray(s, color)
  s.systray = wibox.widget{
    base_size = 20,
    opacity = 2,
    visible = true,
    screen = 'primary',
    widget = wibox.widget.systray
  }
  local tray_container = wibox.widget{
    wibox.widget{
      wibox.widget{s.systray, layout = wibox.layout.fixed.horizontal},
      top = dpi(6),
      left = dpi(5),
      right = dpi(5),
      widget = wibox.container.margin
    },
    visible = false,
    bg = beautiful.bg_systray,
    widget = wibox.container.background
  }

  local toggler_widget = font_icons.make_faicon(font_icons.expand, color.hue_400, dpi(8))
  toggler_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awesome.emit_signal('widget::systray:toggle') end
  end)

  awesome.connect_signal('widget::systray:toggle', function()
    tray_container.visible = not tray_container.visible
    if tray_container.visible then
      toggler_widget.change_icon(font_icons.collapse)
    else
      toggler_widget.change_icon(font_icons.expand)
    end
    -- end
  end)
  local result = wibox.widget{tray_container, toggler_widget, layout = wibox.layout.fixed.horizontal}
  return awful.widget.only_on_screen(result, 'primary')
end

return Systray

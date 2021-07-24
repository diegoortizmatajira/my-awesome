local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
panel_visible = false

local function control_bar(s)
  local panel_width = dpi(400)
  local panel_margins = dpi(5)
  local panel = awful.popup{
    widget = {
      {
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(10),
          -- control_center_row_one,
          {
            layout = wibox.layout.stack,
            {
              id = 'main_control',
              visible = true,
              layout = wibox.layout.fixed.vertical,
              spacing = dpi(10)
              -- main_control_row_two,
              -- main_control_row_sliders,
              -- main_control_music_box
            },
            {
              id = 'monitor_control',
              visible = false,
              layout = wibox.layout.fixed.vertical,
              spacing = dpi(10)
              -- monitor_control_row_progressbars
            }
          }
        },
        margins = dpi(16),
        widget = wibox.container.margin
      },
      id = 'control_center',
      -- bg = beautiful.background,
      shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, beautiful.groups_radius)
      end,
      widget = wibox.container.background
    },
    screen = s,
    type = 'dock',
    visible = false,
    ontop = true,
    width = dpi(panel_width),
    maximum_width = dpi(panel_width),
    maximum_height = dpi(s.geometry.height - 38),
    bg = beautiful.transparent,
    fg = beautiful.fg_normal,
    shape = gears.shape.rectangle
  }

  local open_panel = function()
    local focused = awful.screen.focused()
    panel_visible = true

    focused.backdrop_control_center.visible = true
    focused.control_center.visible = true

    panel:emit_signal('opened')
  end

  local close_panel = function()
    local focused = awful.screen.focused()
    panel_visible = false

    focused.control_center.visible = false
    focused.backdrop_control_center.visible = false

    panel:emit_signal('closed')
  end

  -- Hide this panel when app dashboard is called.
  function panel:hide_dashboard()
    close_panel()
  end

  function panel:toggle()
    self.opened = not self.opened
    if self.opened then
      open_panel()
    else
      close_panel()
    end
  end

  awful.placement.top_right(panel, {honor_workarea = true, parent = s, margins = {top = dpi(33), right = dpi(5)}})

  panel.opened = false

  s.backdrop_control_center = wibox{
    ontop = true,
    screen = s,
    bg = beautiful.transparent,
    type = 'utility',
    x = s.geometry.x,
    y = s.geometry.y,
    width = s.geometry.width,
    height = s.geometry.height
  }

  s.backdrop_control_center:buttons(awful.util.table.join(awful.button({}, 1, nil, function()
    panel:toggle()
  end)))

  return panel
end

return control_bar

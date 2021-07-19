local font_icons = require('widget.font-icons')
local mat_colors = require('theme.mat-colors')
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local batteryarc_widget = {}

local function worker(user_args)

  local args = user_args or {}

  local font = args.font or 'Play 6'
  local arc_thickness = args.arc_thickness or 2
  local size = args.size or 18
  local timeout = args.timeout or 10
  local show_notification_mode = args.show_notification_mode or 'on_hover' -- on_hover / on_click

  local main_color = args.main_color or beautiful.fg_color
  local bg_color = args.bg_color or '#ffffff11'
  local low_level_color = args.low_level_color or '#e53935'
  local medium_level_color = args.medium_level_color or '#c0ca33'
  local charging_color = args.charging_color or '#43a047'
  local icon_color = args.icon_color or beautiful.fg_color

  local text = wibox.widget{
    font = font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
    markup = string.format([[<span color='%s'>%s</span>]], icon_color, font_icons.battery)
  }

  local text_with_background = wibox.container.background(text)

  batteryarc_widget = wibox.widget{
    text_with_background,
    max_value = 100,
    rounded_edge = true,
    thickness = arc_thickness,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = size,
    forced_width = size,
    bg = bg_color,
    paddings = 2,
    widget = wibox.container.arcchart
  }

  local function update_widget(widget, stdout)
    local charge = 100
    local status
    for s in stdout:gmatch("[^\r\n]+") do
      local cur_status, charge_str, _ = string.match(s, '.+: (%a+), (%d?%d?%d)%%,?(.*)')
      if cur_status ~= nil and charge_str ~= nil then
        local cur_charge = tonumber(charge_str)
        if cur_charge ~= charge then
          status = cur_status
          charge = cur_charge
        end
      end
    end

    widget.value = charge

    if status == 'Charging' then
      text_with_background.bg = charging_color
      text_with_background.fg = '#000000'
    else
      text_with_background.bg = '#00000000'
      text_with_background.fg = main_color
    end

    if charge < 15 then
      widget.colors = {low_level_color}
    elseif charge > 15 and charge < 40 then
      widget.colors = {medium_level_color}
    else
      widget.colors = {main_color}
    end
  end

  watch("acpi", timeout, update_widget, batteryarc_widget)

  -- Popup with battery info
  local notification
  local function show_battery_status()
    awful.spawn.easy_async([[bash -c 'acpi']], function(stdout, _, _, _)
      naughty.destroy(notification)
      notification = naughty.notify{text = stdout, title = "Battery status", timeout = 5, width = 200}
    end)
  end

  if show_notification_mode == 'on_hover' then
    batteryarc_widget:connect_signal("mouse::enter", function()
      show_battery_status()
    end)
    batteryarc_widget:connect_signal("mouse::leave", function()
      naughty.destroy(notification)
    end)
  elseif show_notification_mode == 'on_click' then
    batteryarc_widget:connect_signal('button::press', function(_, _, _, button)
      if (button == 1) then show_battery_status() end
    end)
  end

  return batteryarc_widget

end

local function internal_arc_widget()
  return setmetatable(batteryarc_widget, {
    __call = function(_, ...)
      return worker(...)
    end
  })
end

local function Battery(_, color)
  return {
    {
      internal_arc_widget()({
        show_current_level = true,
        arc_thickness = 2,
        main_color = color.hue_500,
        charging_color = mat_colors.hue_green.hue_A200,
        medium_level_color = mat_colors.orange.hue_500,
        low_level_color = mat_colors.red.hue_700,
        bg_color = color.hue_900,
        icon_color = color.hue_100,
        enable_battery_warning = false
      }),
      layout = wibox.layout.fixed.horizontal
    },
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end

return Battery

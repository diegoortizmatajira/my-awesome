local awful = require('awful')
local apps = require('configuration.apps')

local getDefaultScreen = function(preferredScreen)
  local screen_count = screen.count()
  if preferredScreen <= screen_count then
    return preferredScreen
  else
    return screen_count
  end
end

local tags = {
  {name = 1, icon = '\u{f104}', defaultApp = apps.default.browser, screen = 1, layout = awful.layout.suit.max},
  {name = 2, icon = '\u{f104}', defaultApp = apps.default.rofi, screen = 1, layout = awful.layout.suit.max},
  {name = 3, icon = '\u{f104}', defaultApp = apps.default.rofi, screen = 1, layout = awful.layout.suit.max},
  {name = 4, icon = '', defaultApp = apps.default.rofi, screen = 1, layout = awful.layout.suit.max},
  {name = 5, icon = '', defaultApp = apps.default.rofi, screen = 1, layout = awful.layout.suit.max},
  {name = 6, icon = '', defaultApp = apps.default.rofi, screen = 2, layout = awful.layout.suit.max},
  {name = 7, icon = '\u{f104}', defaultApp = apps.default.rofi, screen = 2, layout = awful.layout.suit.max},
  {name = 8, icon = '\u{f104}', defaultApp = apps.default.music, screen = 2, layout = awful.layout.suit.max},
  {name = 9, icon = '\u{f104}', defaultApp = apps.default.social, screen = 2, layout = awful.layout.suit.tile.left},
  {name = 0, icon = '\u{f104}', defaultApp = apps.default.terminal, screen = 1, layout = awful.layout.suit.max},
  {name = 'Last', icon = '', defaultApp = apps.default.rofi, screen = 3, layout = awful.layout.suit.max}
}

awful.layout.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.right,
  awful.layout.suit.tile.top,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.corner.nw,
  awful.layout.suit.floating
}

local taglist

if taglist == nil or #taglist == 0 then
  taglist = {}
  for _, tag in ipairs(tags) do
    table.insert(taglist, awful.tag.add(tag.name, {
      layout = tag.layout,
      gap_single_client = false,
      gap = 4,
      screen = getDefaultScreen(tag.screen),
      defaultApp = tag.defaultApp
    }))
  end
end

awful.screen.connect_for_each_screen(function(s)
  for _, t in ipairs(taglist) do if t.screen.index == s.index then t:view_only() end end
end)

_G.tag.connect_signal('property::layout', function(t)
  local currentLayout = awful.tag.getproperty(t, 'layout')
  if (currentLayout == awful.layout.suit.max) then
    t.gap = 0
  else
    t.gap = 4
  end
end)

return taglist

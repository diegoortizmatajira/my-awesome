local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local getDefaultScreen = function (preferredScreen)
    if screen.count() >=preferredScreen  then
        return preferredScreen
    else
        return 1
    end
end

local tags = {
    {
        name = 1,
        defaultApp = apps.default.rofi,
        screen = 1
    },
    {
        name = 2,
        defaultApp = apps.default.rofi,
        screen = 2
    },
    {
        name = 3,
        defaultApp = apps.default.rofi,
        screen = 3
    },
    {
        name = 4,
        defaultApp = apps.default.rofi,
        screen = 1
    },
    {
        name = 5,
        defaultApp = apps.default.rofi,
        screen = 1
    },
    {
        name = 6,
        defaultApp = apps.default.rofi,
        screen = 1
    },
    {
        name = 7,
        defaultApp = apps.default.rofi,
        screen = 1
    },
    {
        name = 8,
        defaultApp = apps.default.rofi,
        screen = 1
    },
    {
        name = 9,
        defaultApp = apps.default.rofi,
        screen = 1
    },
}

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
}

local taglist = {}

for i, tag in pairs(tags) do
    table.insert(taglist,
        awful.tag.add(
            tag.name,
            {
                layout = awful.layout.suit.tile,
                gap_single_client = false,
                gap = 4,
                screen = getDefaultScreen(tag.screen),
                defaultApp = tag.defaultApp,
            }
        )
    )
end


awful.screen.connect_for_each_screen(
    function(s)
        for i, t in ipairs(taglist) do
            if t.screen.index == s.index then
                t:view_only()
            end
        end
    end
)


_G.tag.connect_signal(
    'property::layout',
    function(t)
        local currentLayout = awful.tag.getproperty(t, 'layout')
        if (currentLayout == awful.layout.suit.max) then
            t.gap = 0
        else
            t.gap = 4
        end
    end
)

return taglist

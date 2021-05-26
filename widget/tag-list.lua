local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local capi = {button = _G.button}
local clickable_container = require('widget.material.clickable-container')
local modkey = require('configuration.keys.mod').modKey

local TagList = function(s, separator)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = awful.util.table.join(
            awful.button(
                {},
                1,
                function(t)
                    t:view_only()
                end
            ),
            awful.button(
                {modkey},
                1,
                function(t)
                    if _G.client.focus then
                        _G.client.focus:move_to_tag(t)
                        t:view_only()
                    end
                end
            ),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button(
                {modkey},
                3,
                function(t)
                    if _G.client.focus then
                        _G.client.focus:toggle_tag(t)
                    end
                end
            ),
            awful.button(
                {},
                4,
                function(t)
                    awful.tag.viewprev(t.screen)
                end
            ),
            awful.button(
                {},
                5,
                function(t)
                    awful.tag.viewnext(t.screen)
                end
            )
        ),
        layout = {
            spacing = 5,
            spacing_widget = separator,
            layout = wibox.layout.fixed.horizontal
        },
        style = { },
    })
end

return TagList

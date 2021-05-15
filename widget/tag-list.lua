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
        -- widget_template = {
        --     {
        --         {
        --             -- {
        --             --     {
        --             --         id     = 'icon_role',
        --             --         widget = wibox.widget.imagebox,
        --             --     },
        --             --     margins = 2,
        --             --     widget  = wibox.container.margin,
        --             -- },
        --             {
        --                 id     = 'text_role',
        --                 widget = wibox.widget.textbox,
        --             },
        --             layout = wibox.layout.fixed.horizontal,
        --         },
        --         left  = 6,
        --         right = 6,
        --         widget = wibox.container.margin
        --     },
        --     id     = 'background_role',
        --     widget = wibox.container.background,
        --     -- Add support for hover colors and an index label
        --     create_callback = function(self, c3, index, objects) --luacheck: no unused args
        --         self:connect_signal('mouse::enter', function()
        --             if self.bg ~= '#ff0000' then
        --                 self.backup     = self.bg
        --                 self.has_backup = true
        --             end
        --             self.bg = '#ff0000'
        --         end)
        --         self:connect_signal('mouse::leave', function()
        --             if self.has_backup then self.bg = self.backup end
        --         end)
        --     end,
        --     update_callback = function(self, c3, index, objects) --luacheck: no unused args
        --     end,
        -- },
    })
end

return TagList

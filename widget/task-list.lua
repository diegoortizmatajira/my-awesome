local awful = require('awful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local capi = {button = _G.button}
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
--- Common method to create buttons.
-- @tab buttons
-- @param object
-- @treturn table
local function create_buttons(buttons, object)
    if buttons then
        local btns = {}
        for _, b in ipairs(buttons) do
            -- Create a proxy button object: it will receive the real
            -- press and release events, and will propagate them to the
            -- button object the user provided, but with the object as
            -- argument.
            local btn = capi.button {modifiers = b.modifiers, button = b.button}
            btn:connect_signal(
                'press',
                function()
                    b:emit_signal('press', object)
                end
            )
            btn:connect_signal(
                'release',
                function()
                    b:emit_signal('release', object)
                end
            )
            btns[#btns + 1] = btn
        end

        return btns
    end
end

local tasklist_buttons =
    awful.util.table.join(
        awful.button(
            {},
            1,
            function(c)
                if c == _G.client.focus then
                    c.minimized = true
                else
                    -- Without this, the following
                    -- :isvisible() makes no sense
                    c.minimized = false
                    if not c:isvisible() and c.first_tag then
                        c.first_tag:view_only()
                    end
                    -- This will also un-minimize
                    -- the client, if needed
                    _G.client.focus = c
                    c:raise()
                end
            end
        ),
        awful.button(
            {},
            2,
            function(c)
                c.kill(c)
            end
        ),
        awful.button(
            {},
            4,
            function()
                awful.client.focus.byidx(1)
            end
        ),
        awful.button(
            {},
            5,
            function()
                awful.client.focus.byidx(-1)
            end
        )
    )

local TaskList = function(s)
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.alltags,
        buttons = tasklist_buttons,
        layout = wibox.layout.fixed.horizontal(),
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'clienticon',
                            widget = awful.widget.clienticon,
                        },
                        margins = 4,
                        widget  = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 4,
                right = 4,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
                local tooltip = awful.tooltip({
                    objects = { self },
                    align = 'bottom',
                    delay_show = 0.3,
                    mode = 'outside',
                    timer_function = function()
                        return c.name
                    end,
                })
            end,
        },
    })
end

return TaskList

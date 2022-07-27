local awful = require('awful')
require('awful.autofocus')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey

local clientKeys =
    awful.util.table.join(
        awful.key({modkey}, 'm',
            function (c)
                c:swap(awful.client.getmaster())
            end
            , {description = 'Promote to master window', group = 'Windows'}),
        awful.key({modkey}, 'F11',
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = 'Toggle Fullscreen', group = 'Windows'}
        ),
        awful.key({altkey}, 'F4',
            function(c)
                c:kill()
            end,
            {description = 'Close Window', group = 'Windows'}
        ),
        awful.key({modkey}, ',',
            function (_)
                local selection = awful.client.next(-1)
                if selection then
                    client.focus = selection
                    selection:raise()
                end
            end,
            {description = "Previous window in tag", group = "Windows"}),
        awful.key({modkey}, '.',
            function (_)
                local selection = awful.client.next(1)
                if selection then
                    client.focus = selection
                    selection:raise()
                end
            end,
            {description = "Next window in tag", group = "Windows"}),
        awful.key({modkey}, 'Next',
            function(c)
                c.minimized = true
            end ,
            {description = "Minimize", group = "Windows"}),
        awful.key({modkey}, 'Prior',
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "Maximize", group = "Windows"})
    )

return clientKeys

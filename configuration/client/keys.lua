local awful = require('awful')
require('awful.autofocus')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local pageUp = '#112'
local pageDown = '#117'

local clientKeys =
    awful.util.table.join(
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
        awful.key({modkey}, pageDown,
            function(c)
                c.minimized = true
            end ,
            {description = "Minimize", group = "Windows"}),
        awful.key({modkey}, pageUp,
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "Maximize", group = "Windows"})
    )

return clientKeys

local awful = require("awful")
require("awful.autofocus")
local mappings = require("configuration.mappings")
local mapkey = mappings.mapkey

local clientKeys = awful.util.table.join(
	mapkey(mappings.client_swap_master, function(c)
		c:swap(awful.client.getmaster())
	end, { description = "Promote to master window", group = "Windows" }),
	mapkey(mappings.client_full_screen, function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "Toggle Fullscreen", group = "Windows" }),
	mapkey(mappings.client_close, function(c)
		c:kill()
	end, { description = "Close Window", group = "Windows" }),
	mapkey(mappings.client_close_alt, function(c)
		c:kill()
	end, { description = "Close Window", group = "Windows" }),
	mapkey(mappings.client_select_prev, function(_)
		local selection = awful.client.next(-1)
		if selection then
			client.focus = selection
			selection:raise()
		end
	end, { description = "Previous window in tag", group = "Windows" }),
	mapkey(mappings.client_select_next, function(_)
		local selection = awful.client.next(1)
		if selection then
			client.focus = selection
			selection:raise()
		end
	end, { description = "Next window in tag", group = "Windows" }),
	mapkey(mappings.client_minimize, function(c)
		c.minimized = true
	end, { description = "Minimize", group = "Windows" }),
	mapkey(mappings.client_maximize, function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "Maximize", group = "Windows" }),
	mapkey(mappings.client_float, function(c)
		c.floating = not c.floating
	end, { description = "Make floating", group = "Windows" })
)

return clientKeys

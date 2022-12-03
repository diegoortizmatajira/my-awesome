local awful = require("awful")
local input = require("utils.input")
local mappings = require("settings.mappings")
local windows = require("wm.windows")
require("awful.autofocus")

local map_handler = input.map_handler

local client_keys = awful.util.table.join(
	map_handler(
		mappings.client_swap_master,
		windows.promote_to_master_handler,
		{ description = "Promote to master window", group = "Windows" }
	),
	map_handler(
		mappings.client_full_screen,
		windows.fullscreen_handler,
		{ description = "Toggle Fullscreen", group = "Windows" }
	),
	map_handler(
		mappings.client_close, --
		windows.close_handler,
		{ description = "Close Window", group = "Windows" }
	),
	map_handler(
		mappings.client_select_prev,
		windows.select_next_handler,
		{ description = "Previous window in tag", group = "Windows" }
	),
	map_handler(
		mappings.client_select_next,
		windows.select_next_handler,
		{ description = "Next window in tag", group = "Windows" }
	),
	map_handler(
		mappings.client_minimize, --
		windows.minimize_handler,
		{ description = "Minimize", group = "Windows" }
	),
	map_handler(
		mappings.client_maximize, --
		windows.toggle_maximize_handler,
		{ description = "Maximize", group = "Windows" }
	),
	map_handler(
		mappings.client_float, --
		windows.toggle_floating_handler,
		{ description = "Make floating", group = "Windows" }
	)
)

return client_keys

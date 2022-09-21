local awful = require("awful")

local metaKey = "Mod4"
local altKey = "Mod1"
local shiftKey = "Shift"
local ctrlKey = "Control"

local vim = {
	Up = "k",
	Down = "j",
	Left = "h",
	Right = "l",
}

local common = {
	Up = "Up",
	Down = "Down",
	Left = "Left",
	Right = "Right",
	Return = "Return",
	PageUp = "Prior",
	PageDown = "Next",
}

local function mapkey(keymap, handler, help)
	if keymap.keyname then
		return awful.key(keymap.modifiers, keymap.keyname, handler, help)
	else
		local result = {}
		for _, mapping in ipairs(keymap) do
			result = awful.util.table.join(result, mapkey(mapping, handler, help))
		end
		return result
	end
end

local function key(modifiers, keyname)
	return {
		modifiers = modifiers,
		keyname = keyname,
	}
end

return {
	app_workspace_default = key({ metaKey }, common.Return),
	awesome_help = key({ metaKey }, "F1"),
	awesome_quit = key({ metaKey, ctrlKey }, "q"),
	awesome_restart = key({ metaKey, ctrlKey }, "r"),
	client_close = { key({ altKey }, "F4"), key({ metaKey }, "w") },
	client_float = key({ altKey }, "f"),
	client_full_screen = key({ metaKey }, "F11"),
	client_maximize = key({ metaKey }, common.PageUp),
	client_minimize = key({ metaKey }, common.PageDown),
	client_minimize_all = key({ metaKey, shiftKey }, common.PageDown),
	client_restore_all = key({ metaKey, shiftKey }, common.PageUp),
	client_select_above = { key({ metaKey }, vim.Up), key({ metaKey }, common.Up) },
	client_select_below = { key({ metaKey }, vim.Down), key({ metaKey }, common.Down) },
	client_select_left = { key({ metaKey }, vim.Left), key({ metaKey }, common.Left) },
	client_select_next = key({ metaKey }, "."),
	client_select_prev = key({ metaKey }, ","),
	client_select_right = { key({ metaKey }, vim.Right), key({ metaKey }, common.Right) },
	client_select_urgent = key({ metaKey }, "u"),
	client_swap_master = key({ metaKey }, "m"),
	client_switch = key({ altKey }, "Tab"),
	prefix_workspace_goto = { metaKey },
	prefix_workspace_moveto = { metaKey, shiftKey },
	prefix_workspace_toggle = { metaKey, ctrlKey },
	system_next_wallpaper = key({ metaKey, shiftKey }, "d"),
	system_show_desktop = key({ metaKey }, "d"),
	workspace_find_empty = key({ metaKey }, "n"),
	workspace_move_to_empty = key({ metaKey, shiftKey }, "n"),
	workspace_next = { key({ metaKey, ctrlKey }, vim.Up), key({ metaKey, ctrlKey }, common.Up) },
	workspace_next_layout = key({ altKey }, "r"),
	workspace_prev_layout = key({ altKey, shiftKey }, "r"),
	workspace_previous = { key({ metaKey, ctrlKey }, vim.Down), key({ metaKey, ctrlKey }, common.Down) },
	workspace_relocate = key({ metaKey, shiftKey }, "r"),
	workspace_resize_layout = key({ metaKey }, "r"),
	workspace_switch = key({ metaKey }, "Tab"),
	mapkey = mapkey,
	key = key,
}

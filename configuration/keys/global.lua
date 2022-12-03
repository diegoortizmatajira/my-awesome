local awful = require("awful")
local apps = require("utils.apps")
local layouts = require("wm.layouts")
local windows = require("wm.windows")
local workspaces = require("wm.workspaces")
local mappings = require("settings.mappings")
local modalbind = require("utils.modal-bind")
local input = require("utils.input")
local map_handler, key = input.map_handler, input.key
modalbind.init()

require("awful.autofocus")

local function modal_handler(options)
	return function()
		modalbind.grab(options)
	end
end

local function move_tag_to_screen(relative)
	local t = client.focus and client.focus.first_tag or nil
	if t == nil then
		return
	end
	awful.screen.focus_bydirection(relative, t.screen)
	t.screen = awful.screen.focused()
	awful.tag.viewonly(t)
end

local screen_move_map = {
	{
		"h",
		function()
			move_tag_to_screen("left")
		end,
		"Move to screen on the left",
	},
	{
		"l",
		function()
			move_tag_to_screen("right")
		end,
		"Move to screen on the right",
	},
	{
		"k",
		function()
			move_tag_to_screen("up")
		end,
		"Move to screen above",
	},
	{
		"j",
		function()
			move_tag_to_screen("down")
		end,
		"Move to screen below",
	},
}

local layout_modify_map = {
	{
		"h",
		function()
			awful.tag.incmwfact(-0.05)
		end,
		"Decrease Master Size",
	},
	{
		"l",
		function()
			awful.tag.incmwfact(0.05)
		end,
		"Increase Master Size",
	},
	{
		"j",
		function()
			awful.tag.incnmaster(-1, nil, true)
		end,
		"Decrease Master Count",
	},
	{
		"k",
		function()
			awful.tag.incnmaster(1, nil, true)
		end,
		"Increase Master Count",
	},
	{
		"u",
		function()
			awful.tag.incncol(-1, nil, true)
		end,
		"Decrease Column Count",
	},
	{
		"i",
		function()
			awful.tag.incncol(1, nil, true)
		end,
		"Increase Column Count",
	},
}

-- Key bindings
local global_keys = awful.util.table.join(
	map_handler(
		mappings.awesome_restart,
		apps.awesome_restart_handler,
		{ description = "Reload Awesome Window Manager", group = "Awesome" }
	),
	map_handler(
		mappings.awesome_quit,
		apps.awesome_quit_handler,
		{ description = "Quit Awesome Window Manager", group = "Awesome" }
	),
	map_handler(
		mappings.awesome_help,
		apps.awesome_help,
		{ description = "Show help for Awesome Window Manager", group = "Hotkeys" }
	),
	map_handler(
		mappings.system_show_desktop,
		windows.minimize_all_handler,
		{ description = "Show desktop", group = "Hotkeys" }
	),
	map_handler(
		mappings.client_select_below,
		windows.focus_below_handler,
		{ description = "Focus window below", group = "Windows" }
	),
	map_handler(
		mappings.client_select_above,
		windows.focus_above_handler,
		{ description = "Focus window above", group = "Windows" }
	),
	map_handler(
		mappings.client_select_right,
		windows.focus_right_handler,
		{ description = "Focus window on the right", group = "Windows" }
	),
	map_handler(
		mappings.client_select_left,
		windows.focus_left_handler,
		{ description = "Focus window on the left", group = "Windows" }
	),
	map_handler(
		mappings.client_select_urgent,
		windows.jump_to_urgent_handler,
		{ description = "Jump to urgent window", group = "Windows" }
	),
	map_handler(
		mappings.client_switch,
		apps.spawn_app_switcher_handler,
		{ description = "Switch to other window", group = "Windows" }
	),
	map_handler(
		mappings.workspace_previous,
		workspaces.select_prev_handler,
		{ description = "Go to previous workspace", group = "Workspaces" }
	),
	map_handler(
		mappings.workspace_next,
		workspaces.select_next_handler,
		{ description = "Go to next workspace", group = "Workspaces" }
	),
	map_handler(
		mappings.workspace_switch,
		awful.tag.history.restore,
		{ description = "Go to last used workspace", group = "Workspaces" }
	),
	map_handler(
		mappings.app_workspace_default,
		apps.spawn_default_app_handler,
		{ description = "Open default program for workspace", group = "Applications" }
	),
	map_handler(
		mappings.workspace_resize_layout,
		modal_handler({ keymap = layout_modify_map, name = "Modify layout", stay_in_mode = true }),
		{ description = "Resizes the current layout", group = "Modes" }
	),
	map_handler(
		mappings.workspace_relocate,
		modal_handler({ keymap = screen_move_map, name = "Move current tag to screen", stay_in_mode = true }),
		{ description = "Relocate current Tag", group = "Modes" }
	),
	map_handler(
		mappings.workspace_next_layout,
		layouts.apply_next_handler,
		{ description = "Select next Layout", group = "Layout Distribution" }
	),
	map_handler(
		mappings.workspace_prev_layout,
		layouts.apply_previous_handler,
		{ description = "Select previous Layout", group = "Layout Distribution" }
	),
	map_handler(
		mappings.client_restore_all,
		windows.restore_all_handler,
		{ description = "Restore all windows", group = "Windows" }
	),
	map_handler(
		mappings.client_minimize_all,
		windows.minimize_all_handler,
		{ description = "Restore minimized", group = "Windows" }
	),
	map_handler(
		mappings.workspace_find_empty,
		workspaces.find_empty_handler,
		{ description = "Go to new empty workspace", group = "Workspaces" }
	),
	map_handler(
		mappings.workspace_move_to_empty,
		workspaces.move_to_empty_handler,
		{ description = "Move window to a new empty workspace", group = "Workspaces" }
	)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move
	if i == 1 or i == 10 then
		descr_view = { description = "Focus workspace #", group = "Workspaces" }
		descr_toggle = { description = "Toggle tag visibility #", group = "Workspaces" }
		descr_move = { description = "Move focused window to workspace #", group = "Workspaces" }
	end

	local select_workspace_mapping = {
		key(mappings.prefix_workspace_goto, "#" .. i + 9),
		key(mappings.prefix_workspace_goto, "#" .. input.numpad_keycodes[i]),
	}
	local toggle_workspace_mapping = {
		key(mappings.prefix_workspace_toggle, "#" .. i + 9),
		key(mappings.prefix_workspace_toggle, "#" .. input.numpad_keycodes[i]),
	}
	local move_to_workspace_mapping = {
		key(mappings.prefix_workspace_moveto, "#" .. i + 9),
		key(mappings.prefix_workspace_moveto, "#" .. input.numpad_keycodes[i]),
	}
	global_keys = awful.util.table.join(
		global_keys, -- View tag only.
		map_handler(select_workspace_mapping, workspaces.select_by_index_handler(i), descr_view),
		map_handler(toggle_workspace_mapping, workspaces.toggle_by_index_handler(i), descr_toggle),
		map_handler(move_to_workspace_mapping, workspaces.assign_by_index_handler(i), descr_move)
	)
end

return global_keys

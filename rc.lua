local beautiful = require("beautiful")
local default_theme = require("settings.theme")
local awful = require("awful")
require("awful.autofocus")
local gears = require("gears")

-- Theme
beautiful.init(default_theme)

-- Layout
require("wm.ui")

-- Init all modules
require("module.notifications")
require("module.auto-start")
require("module.decorate-client")
-- Backdrop causes bugs on some gtk3 applications
-- require('module.backdrop')

-- Setup all configurations
require("wm.windows")
require("wm.workspaces")
require("wm.keyboard")

-- Run garbage collector regularly to prevent memory leaks
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})

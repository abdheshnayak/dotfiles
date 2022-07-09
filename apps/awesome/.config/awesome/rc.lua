local gears = require "gears"
local beautiful = require "beautiful"
local awful = require "awful"
require "awful.autofocus"

-- Shell
awful.util.shell = "sh"

-- Theme
beautiful.init(require "theme")

-- Layout
require "layout"

-- Config
require "client"
require "keys"

-- Module
require "module.notifications"
require "module.quake-terminal"
require "module.brightness-osd"
require "module.volume-osd"

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
	gears.wallpaper.maximized(beautiful.wallpaper, s)
end)

-- Startup apps
do
	local cmds =
	{
		"redshift -x",
		"redshift -O 3000",
		"remaps",
		"sudo fusuma -c ~/.config/fusuma/config.yml"
	}

	for _, i in pairs(cmds) do
		awful.spawn.single_instance(i, awful.rules.rules)
	end
end

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
}

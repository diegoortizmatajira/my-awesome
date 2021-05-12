local filesystem = require('gears.filesystem')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'custom-launcher'

return {
    -- List of apps to start by default on some actions
    default = {
        terminal = 'kitty',
        rofi = rofi_command,
        lock = 'custom-lock',
        quake = 'kitty',
        screenshot = 'flameshot screen -c',
        region_screenshot = 'flameshot gui -c',
        delayed_screenshot = 'flameshot screen -d 5000',
        browser = 'firefox-developer-edition',
        editor = 'subl', -- gui text editor
        social = rofi_command,
        game = rofi_command,
        files = 'nautilus',
        music = rofi_command
    },
    -- List of apps to start once on start-up
    run_on_start_up = {
        'picom -bc',
        'nm-applet --indicator', -- wifi
        'pnmixer', -- shows an audiocontrol applet in systray when installed.
        'blueman-applet', -- Bluetooth applet
        '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
        'xfce4-power-manager', -- Power manager
        'custom-wallpaper',
        'clipmenud',
        '/usr/lib/kdeconnectd',
        'barrier',
        -- Add applications that need to be killed between reloads
        -- to avoid multipled instances, inside the awspawn script
        '~/.config/awesome/configuration/awspawn' -- Spawn "dirty" apps that can linger between sessions
    }
}

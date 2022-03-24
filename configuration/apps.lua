local rofi_command = 'custom-launcher'

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'kitty',
    rofi = rofi_command,
    lock = 'custom-lock',
    quake = 'kitty',
    screenshot = 'flameshot screen -c',
    region_screenshot = 'flameshot gui',
    delayed_screenshot = 'flameshot screen -c -d 5000',
    browser = 'firefox-developer-edition',
    editor = 'subl', -- gui text editor
    social = rofi_command,
    game = rofi_command,
    files = 'nautilus',
    music = rofi_command
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    'picom -b --experimental-backends --dbus',
    'nm-applet --indicator', -- wifi
    'blueman-applet', -- Bluetooth applet
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    'xfce4-power-manager', -- Power manager
    'custom-wallpaper',
    'clipmenud',
    'barrier',
    [[xcape -e 'Super_L=Super_L|Control_L|Escape']],
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    '~/.config/awesome/configuration/awspawn' -- Spawn "dirty" apps that can linger between sessions
  },
  -- List of binaries/shell scripts that will execute for a certain task
  utils = {
    profile_image = 'profile-image'
  }
}

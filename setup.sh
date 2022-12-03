#!/usr/bin/env bash
#<----------------Installing Linux Apps via pacman/yay-------------------->

base_desktop_environment=(
# xfce4
    exo
    garcon
    xfce4-power-manager
    xfce4-session
    xfce4-settings
    xfconf
    xfce4-clipman-plugin
    xfce4-battery-plugin
    xfce4-datetime-plugin
    xfce4-mpc-plugin
    xfce4-notifyd
    xfce4-taskmanager
    xfce4-screensaver
# tiling window manager
    picom-git
    awesome
    ocs-url
    rofi
    rofi-dmenu
# bluetooth
    blueman
    bluez-plugins
    bluez-utils
# audio
    alsa-utils
    pulseaudio-alsa
    pulseaudio-bluetooth
    playerctl
# network
    network-manager-applet
    networkmanager
    wireguard-tools
    wireless_tools
# power management
    acpi
    tlp
    tlp-rdw
# file management
    ntfs-3g
    nautilus
    nautilus-sendto
    file
    file-roller
    filesystem
    findutils
    goto
# fonts
    apple-fonts
    otf-nerd-fonts-fira-code
    ttf-fira-code
    ttf-font-awesome
    ttf-jetbrains-mono
    ttf-mac-fonts
)

unneeded_packages=(
    xfce4-panel
    xfdesktop
    xfwm4
)

yay -Syu --needed --noconfirm

yay -Sy ${base_desktop_environment[@]} --needed 

yay -Rsc ${unneeded_packages[@]} 

xfconf-query -c xfce4-session -p /sessions/Failsafe/Client0_Command -t string -sa xfsettingsd
xfconf-query -c xfce4-session -p /sessions/Failsafe/Client1_Command -t string -sa awesome
gsettings set  org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

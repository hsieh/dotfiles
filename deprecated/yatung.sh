#!/bin/sh
xsetroot -xcf /usr/share/icons/Adwaita/cursors/right_ptr 96
xrandr --output DP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --dpi 96 --scale 2x2 --output HDMI1 --off --output DP2 --mode 3840x2160 --pos 3840x0 --rotate normal --dpi 192 --output HDMI2 --off --output DP-3 --off --output HDMI-3 --off
xset r rate 300 50
fcitx -r -d

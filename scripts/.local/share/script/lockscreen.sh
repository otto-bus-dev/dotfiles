#!/bin/bash

# Take a screenshot and blur it
#convert /home/otto/Pictures/Wallpapers/wallpaper.png -blur 0x10 /tmp/screen_blur.png

# Start the lock screen with the blurred image
hyprlock -c /home/otto/.local/share/script/hyprlock.conf

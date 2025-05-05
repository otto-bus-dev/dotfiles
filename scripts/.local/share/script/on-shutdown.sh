#!/bin/bash
# Take a screenshot and blur it
#convert /home/otto/Pictures/Wallpapers/wallpaper.png -blur 0x10 /tmp/screen_blur.png
killall streamdeck
while pgrep streamdeck > /dev/null; do
    sleep 0.1
done
shutdown -h now


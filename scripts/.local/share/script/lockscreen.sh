#!/bin/bash

# Take a screenshot and blur it
#convert /home/otto/Pictures/Wallpapers/wallpaper.png -blur 0x10 /tmp/screen_blur.png

killall -9 streamdeck
while pgrep streamdeck > /dev/null; do
    sleep 0.1
done
# Start the lock screen with the blurred image
if [ -z "$1" ]; then
  pidof hyprlock || hyprlock &
else
  pidof hyprlock || hyprlock -c /home/otto/.local/share/script/hyprlock.conf &
fi

# Wait for hyprlock to exit (indicating unlock)
wait $!

# Ensure hyprlock is no longer running
while pgrep hyprlock > /dev/null; do
    sleep 0.1
done

# Call the unlock command
/home/otto/.local/share/script/unlockscreen.sh


#!/bin/bash
source ~/.local/share/script/stop_streamdeck.sh

# Start the lock screen with the blurred image
if [ -z "$1" ]; then
  pidof hyprlock || hyprlock &
else
  pidof hyprlock || hyprlock -c /home/otto/.local/share/script/hyprlock.conf &
fi

# Ensure hyprlock is no longer runninuh
while pgrep hyprlock > /dev/null; do
 sleep 0.1
done

# Call the unlock command
/home/otto/.local/share/script/unlockscreen.sh


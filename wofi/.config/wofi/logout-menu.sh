#!/bin/bash

# Create a list of options
options="lock\nreboot\nshutdown"

# Use wofi in dmenu mode to let the user select an option
selection=$(echo -e "$options" | wofi --dmenu --height 150 --width 200 --prompt "Select an option")

# Take action based on the selection
case "$selection" in
  "lock")
	pidof hyprlock || hyprlock
    ;;
  "reboot")
   	reboot 
    ;;
  "shutdown")
	shutdown
    ;;
  *)
    echo "No valid option selected."
    ;;
esac

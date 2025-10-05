#!/bin/bash

# Start Hyprland
Hyprland > /dev/null 2>&1

# Wait until Hyprland initializes
while ! pgrep -x "Hyprland" > /dev/null; do
    sleep 0.1
done

# Quit Plymouth gracefully
plymouth quit

#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"

# Directory where the wallpaper.png will be stored
TARGET_DIR="$HOME/Pictures/Wallpapers/Selected/"
TARGET_FILE="wallpaper.png"

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

while true; do
    # Get a random wallpaper
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    # Copy the wallpaper to the target directory as wallpaper.png
    cp "$WALLPAPER" "$TARGET_DIR$TARGET_FILE"

    # Reload the wallpaper in Hyprpaper
    hyprctl hyprpaper reload ,"$TARGET_DIR$TARGET_FILE"

    # Wait for 5 minutes
    sleep 300
done

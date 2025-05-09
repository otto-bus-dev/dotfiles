#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/otto/.config/wallpapers/all/"

# Directory where the wallpaper.png will be stored
TARGET_DIR="/home/otto/.config/wallpapers/selected/"
TARGET_FILE="wallpaper.png"
TARGET_BLUR_FILE="wallpaper_blur.png"
#TARGET_SPLASH_SCREEN_BACKGROUND_PATH="/usr/share/plymouth/themes/spinner/background-tile.png"
# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

while true; do
    # Wait for 5 minutes
    sleep 300
    # Get a random wallpaper
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    # Copy the wallpaper to the target directory as wallpaper.png
    cp "$WALLPAPER" "$TARGET_DIR$TARGET_FILE"
    
    #sudo cp "$WALLPAPER" "$TARGET_SPLASH_SCREEN_BACKGROUND_PATH"
    #sudo magick "$TARGET_DIR$TARGET_FILE" -resize 2560x1600 "$TARGET_SPLASH_SCREEN_BACKGROUND_PATH"
    magick "$TARGET_DIR$TARGET_FILE" -blur 0x10 "$TARGET_DIR$TARGET_BLUR_FILE"
    # sudo mkinitcpio -P linux

    # Reload the wallpaper in Hyprpaper
    hyprctl hyprpaper reload "$TARGET_DIR$TARGET_FILE"

done

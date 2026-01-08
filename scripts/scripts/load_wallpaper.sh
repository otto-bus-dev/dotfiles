#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/otto/.config/wallpapers/all/"

# Directory where the wallpaper.png will be stored
TARGET_DIR="/home/otto/.config/wallpapers/selected/"
TARGET_FILE="wallpaper.png"
TARGET_BLUR_FILE="wallpaper_blur.png"
PID_FILE="/tmp/load_wallpaper.pid"

# Cleanup function
cleanup() {
    echo "Stopping wallpaper rotation..."
    rm -f "$PID_FILE"
    exit 0
}

# Set up signal handlers
trap cleanup SIGTERM SIGINT

# Check if already running
if [ -f "$PID_FILE" ]; then
    OLD_PID=$(cat "$PID_FILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo "Wallpaper rotation already running (PID: $OLD_PID)"
        echo "To stop it, run: kill $OLD_PID"
        exit 1
    else
        # Stale PID file, remove it
        rm -f "$PID_FILE"
    fi
fi

# Write our PID
echo $$ > "$PID_FILE"

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Check if wallpaper directory exists and has files
if [ ! -d "$WALLPAPER_DIR" ] || [ -z "$(ls -A "$WALLPAPER_DIR" 2>/dev/null)" ]; then
    echo "Error: Wallpaper directory '$WALLPAPER_DIR' is empty or doesn't exist"
    cleanup
fi

echo "Starting wallpaper rotation (PID: $$)"
echo "To stop: kill $$ or run 'pkill -f load_wallpaper.sh'"

while true; do
    # Get a random wallpaper
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

    if [ -z "$WALLPAPER" ]; then
        echo "Warning: No wallpapers found, retrying in 5 minutes..."
        sleep 300
        continue
    fi

    # Copy the wallpaper to the target directory
    if ! cp "$WALLPAPER" "$TARGET_DIR$TARGET_FILE" 2>/dev/null; then
        echo "Warning: Failed to copy wallpaper, retrying..."
        sleep 10
        continue
    fi

    # Create blurred version (using nice to reduce CPU priority)
    if ! nice -n 15 magick "$TARGET_DIR$TARGET_FILE" -blur 0x10 "$TARGET_DIR$TARGET_BLUR_FILE" 2>/dev/null; then
        echo "Warning: Failed to create blurred wallpaper"
    fi

    # Reload the wallpaper in Hyprpaper
    if ! hyprctl hyprpaper wallpaper ,"$TARGET_DIR$TARGET_FILE" 2>/dev/null; then
        echo "Warning: Failed to set wallpaper via hyprctl"
    fi

    # Wait for 5 minutes (or until interrupted)
    sleep 300 &
    wait $!
done

#!/bin/bash
LOCKFILE="/tmp/wofi.lock"

exec 200>"$LOCKFILE"
flock -n 200 || exit 1

if [[ -n "$1" ]]; then
  CONFIG_FILE="$HOME/.config/wofi/$1.json"
else
  MODE="$HOME/.config/wofi/app.json"
fi


# Read the prompt from the JSON file
prompt=$(jq -r '.prompt' "$CONFIG_FILE")
if [[ "$prompt" == "null" ]]; then
  prompt="Select an app" # Set a default prompt if not provided in the config
fi

# Read options and actions from the JSON file
options=$(jq -r '.options[] | .option' "$CONFIG_FILE")
declare -A actions
while IFS= read -r line; do
  key=$(echo "$line" | jq -r '.option')
  value=$(echo "$line" | jq -r '.action')
  actions["$key"]="$value"
done < <(jq -c '.options[]' "$CONFIG_FILE")

# Calculate the height of the menu based on the number of options
num_options=$(jq '.options | length' "$CONFIG_FILE")
menu_height=$((50 +  num_options * 35)) # Adjust 50 to fit your desired row height

# Use wofi in dmenu mode to let the user select an option
selection=$(echo -e "$options" | wofi --dmenu --gtk-layer-shell --height "$menu_height" --width 200 --prompt "$prompt" )

pkill -SIGUSR1 waybar
rm -f "$LOCKFILE"
# Take action based on the selection
if [[ -n "$selection" ]] && [[ -n "${actions[$selection]}" ]]; then
  # Execute the action associated with the selected option
  eval "${actions[$selection]}"
else
  echo "No valid option selected."
fi

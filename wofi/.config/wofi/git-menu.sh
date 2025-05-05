#!/bin/bash
LOCKFILE="/tmp/wofi.lock"

exec 200>"$LOCKFILE"
flock -n 200 || exit 1

pkill -SIGUSR1 waybar
if [[ -n "$1" ]]; then
  search_dir="$1"
else
  search_dir="/home/otto/dotfiles/ /home/otto/.config/"
fi

declare -a options
declare -A actions

while IFS= read -r file; do
  # Extract values from the JSON file using jq
  option=$(jq -r '.option' "$file")
  action=$(jq -r '.action' "$file")
  actions["$option"]="$action"
  options+=("$option")
done < <(find $search_dir -type f -name .otto)

# Loop through JSON files found by the `find` command
#
prompt="Select a repo" # Set a default prompt if not provided in the config
# Calculate the height of the menu based on the number of options
num_options=${#options[@]}
menu_height=$((50 +  num_options * 35)) # Adjust 50 to fit your desired row height
# Use wofi in dmenu mode to let the user select an option
selection=$(printf "%s\n" "${options[@]}" | wofi --dmenu --gtk-layer-shell --height "$menu_height" --width 200 --prompt "$prompt" )

rm -f "$LOCKFILE"
echo "Selected option: $selection"
# Take action based on the selection
if [[ -n "$selection" ]] && [[ -n "${actions[$selection]}" ]]; then
  
  export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
  export GPG_AGENT_INFO=$XDG_RUNTIME_DIR/keyring/gpg
  export SESSION_MANAGER=$XDG_RUNTIME_DIR/keyring
 
  # Your existing script logic
  kitty -d "${actions[$selection]}" lazygit
else
  echo "No valid option selected."
fi

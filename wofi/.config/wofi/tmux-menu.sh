#!/bin/bash
LOCKFILE="/tmp/wofi.lock"

exec 200>"$LOCKFILE"
flock -n 200 || exit 1

if [[ -n "$1" ]]; then
  search_dir="$1"
else
  search_dir="$HOME"
fi

declare -a options
declare -A actions
while IFS= read -r session; do
  # Extract values from the JSON file using jq
  option="$session"
  action="kitty sh -c 'tmux attach -t $session;exec sh'"

  actions["$option"]="$action"
  options+=("$option")
done < <(tmux list-sessions -F '#S')
option="new"
action="kitty sh -c \"read -p 'Enter new session name : ' new_name;echo \\\$new_name;tmux new-session -s  \\\"\\\$new_name\\\"; exec sh\""
actions["$option"]="$action"
options+=("$option")

prompt="Select a tmux session" # Set a default prompt if not provided in the config
# Calculate the height of the menu based on the number of options
num_options=${#options[@]}
menu_height=$((50 +  num_options * 35)) # Adjust 50 to fit your desired row height
# Use wofi in dmenu mode to let the user select an option
selection=$(printf "%s\n" "${options[@]}" | wofi --dmenu --gtk-layer-shell --height "$menu_height" --width 200 --prompt "$prompt" )

pkill -SIGUSR1 waybar
rm -f "$LOCKFILE"
echo "Selected option: $selection"
# Take action based on the selection
if [[ -n "$selection" ]] && [[ -n "${actions[$selection]}" ]]; then
  # Execute the action associated with the selected option
  eval "${actions[$selection]}"
else
  echo "No valid option selected."
fi


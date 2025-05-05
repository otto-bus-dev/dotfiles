#!/bin/bash
LOCKFILE="/tmp/wofi.lock"

exec 200>"$LOCKFILE"
flock -n 200 || exit 1


pkill -SIGUSR1 waybar
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
  action="kitty tmux attach -t $session"

  actions["$option"]="$action"
  options+=("$option")
done < <(tmux list-sessions -F '#S')
option="new"

#action="kitty sh -c \"read -p 'Enter new session name : ' new_name;echo \\\$new_name;tmux new-session -s  \\\"\\\$new_name\\\"; exec sh\""
action="kitty eval \"read -p 'Enter new session name : ' new_name;tmux new-session -s  \\\"$new_name\\\"\""
actions["$option"]="$action"
options+=("$option")

prompt="Select a tmux session" # Set a default prompt if not provided in the config
# Calculate the height of the menu based on the number of options
num_options=${#options[@]}
menu_height=$((50 +  num_options * 35)) # Adjust 50 to fit your desired row height
# Use wofi in dmenu mode to let the user select an option
selection=$(printf "%s\n" "${options[@]}" | wofi --dmenu --gtk-layer-shell --height "$menu_height" --width 200 --prompt "$prompt" )

echo "Selected option: $selection"

if [[ "$selection" == "new" ]]; then
  # Execute the action associated with the selected option
  selection=$(printf "%s\n" "${options[@]}" | wofi --dmenu --gtk-layer-shell --height 70 --width 200 --prompt "Enter the name of the new tmux session" )
  rm -f "$LOCKFILE"
  kitty  tmux new-session -s $selection 
else
  rm -f "$LOCKFILE"
  # Take action based on the selection
  if [[ -n "$selection" ]] && [[ -n "${actions[$selection]}" ]]; then
    # Execute the action associated with the selected option
    eval "${actions[$selection]}"
  else
    echo "No valid option selected."
  fi
fi


#!/usr/bin/env bash

# Get the workspace information
workspaces=$(hyprctl clients -j | sed -e 's/\x1b\[[0-9;]*m//g' | jq -r '.[] | .workspace.id')
# Initialize an empty string to hold the result
result="["

# Loop through each workspace
for workspace in $workspaces; do
  # Get the applications in the current workspace
  apps=$(hyprctl clients -j | sed -e 's/\x1b\[[0-9;]*m//g' |  jq -r --arg ws $workspace '
    .[] | select(.workspace.id == ($ws | tonumber)) | .class' | tr '\n' ', ' | sed 's/, $//')
	final_apps=""
	for app in $apps; do
		case $app in 
			"Brave-browser,")
				final_apps+="󰖟 "
				;;
			"kitty,")
				final_apps+="󰄛 "
				;;
			"org.gnome.Nautilus,")
				final_apps+="󰥨 " 
				;;
			*)
				final_apps+=$app
				;;
		esac
	done
	final_apps=$(echo "$final_apps" | sed 's/,$//')
  # Add the workspace and its applications to the result
  result+="{\"text\":\"$workspace:$final_apps\",\"tooltip\":\"workspace\",\"class\":\"workspace\",\"percentage\":1},"

done
result=$(echo "$result" | sed 's/,$//')
result="${result%, }]"
# Join the array into a JSON array string
json_array=$(printf ",%s" "${result[@]}")
json_array="${json_array:1}"

# Create a single JSON object for Waybar
waybar_output=$(echo "$json_array" | jq -c 'reduce .[] as $item ({}; .text += "\($item.id): \($item.apps), ") | .text = .text[:-2]')
echo "{\"text\":\"pace:al_apps\",\"tooltip\":\"workspace\",\"class\":\"workspace\",\"percentage\":1},"

# Output the final JSON result
# echo "$json_array"

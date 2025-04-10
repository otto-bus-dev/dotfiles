#!/bin/bash

# Check if bluetoothctl is installed
if ! command -v bluetoothctl &> /dev/null
then
    echo "bluetoothctl could not be found. Please install it and try again."
    exit 1
fi

# Check if wofi is installed
if ! command -v wofi &> /dev/null
then
    echo "wofi could not be found. Please install it and try again."
    exit 1
fi

# Scan for Bluetooth devices
echo "Scanning for Bluetooth devices..."
#bluetoothctl scan on &> /dev/null & # Start scanning in the background
bluetoothctl scan bredr &> /dev/null & # Start scanning in the background

sleep 5                            # Wait for 5 seconds to gather results


bluetoothctl scan off              # Stop scanning

# Get a list of devices
devices=$(bluetoothctl devices)

# Check if any devices were found
if [ -z "$devices" ]; then
    echo "No Bluetooth devices found."
    exit 0
fi

# Display the devices in wofi
selected_device=$(echo "$devices" | wofi --dmenu --prompt "Select Bluetooth Device")

# Handle the selected device
if [ -n "$selected_device" ]; then
    echo "You selected: $selected_device"
else
    echo "No device selected."
fi
echo -e "scan on\nscan le\ndevices" | bluetoothctl

#!/bin/bash

# Get the public IP address
IP=$(curl -s https://api64.ipify.org)

# Fetch geolocation data (replace with your preferred GeoIP API)
LOCATION=$(curl -s "https://ipapi.co/${IP}/json")

# Extract timezone using jq
TIMEZONE=$(echo "$LOCATION" | jq -r '.timezone')

# Check if timezone was successfully retrieved
if [ "$TIMEZONE" != "null" ] && [ -n "$TIMEZONE" ]; then
    echo "Setting timezone to: $TIMEZONE"
    sudo timedatectl set-timezone "$TIMEZONE"
    echo "Timezone updated successfully!"
else
    echo "Failed to detect timezone. Please check your internet connection or GeoIP service."
    exit 1
fi

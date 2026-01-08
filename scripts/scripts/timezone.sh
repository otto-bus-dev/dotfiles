#!/bin/bash
set -e

CURL_TIMEOUT=10

# Get the public IP address
echo "Fetching public IP address..."
if ! IP=$(curl -s --connect-timeout $CURL_TIMEOUT --max-time $CURL_TIMEOUT https://api64.ipify.org 2>/dev/null); then
    echo "Error: Failed to fetch public IP address. Check your internet connection."
    exit 1
fi

if [ -z "$IP" ]; then
    echo "Error: Empty IP address received"
    exit 1
fi
echo "✓ Public IP: $IP"

# Fetch geolocation data
echo "Fetching geolocation data..."
if ! LOCATION=$(curl -s --connect-timeout $CURL_TIMEOUT --max-time $CURL_TIMEOUT "https://ipapi.co/${IP}/json" 2>/dev/null); then
    echo "Error: Failed to fetch geolocation data from ipapi.co"
    exit 1
fi

# Check for API rate limit or errors
if echo "$LOCATION" | jq -e '.error' &>/dev/null; then
    ERROR_MSG=$(echo "$LOCATION" | jq -r '.reason // .error')
    echo "Error: API returned an error: $ERROR_MSG"
    exit 1
fi

# Extract timezone using jq
TIMEZONE=$(echo "$LOCATION" | jq -r '.timezone')

# Check if timezone was successfully retrieved
if [ "$TIMEZONE" = "null" ] || [ -z "$TIMEZONE" ]; then
    echo "Error: Failed to detect timezone from geolocation data"
    exit 1
fi

# Validate timezone exists on system
if ! timedatectl list-timezones | grep -Fxq "$TIMEZONE"; then
    echo "Error: Timezone '$TIMEZONE' is not valid on this system"
    exit 1
fi

# Get current timezone
CURRENT_TZ=$(timedatectl show -p Timezone --value)

if [ "$CURRENT_TZ" = "$TIMEZONE" ]; then
    echo "✓ Timezone is already set to: $TIMEZONE"
    exit 0
fi

# Ask for confirmation
echo ""
echo "Current timezone: $CURRENT_TZ"
echo "Detected timezone: $TIMEZONE"
read -p "Do you want to change the timezone? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Timezone change cancelled"
    exit 0
fi

# Change timezone
echo "Setting timezone to: $TIMEZONE"
if sudo timedatectl set-timezone "$TIMEZONE"; then
    echo "✓ Timezone updated successfully!"
else
    echo "Error: Failed to set timezone"
    exit 1
fi

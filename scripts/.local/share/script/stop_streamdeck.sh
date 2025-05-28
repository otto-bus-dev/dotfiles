#!/bin/bash
if pgrep -x "streamdeck" > /dev/null; then
    pkill -x "streamdeck"
    echo "Stream Deck instance killed."
    timeout=50
    elapsed=0
    while pgrep -x "streamdeck" > /dev/null && [ $elapsed -lt $timeout ]; do
        sleep 0.1
        elapsed=$(awk "BEGIN { print $elapsed + 1 }")
    done
fi

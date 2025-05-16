#!/bin/bash
if pgrep -x "streamdeck" > /dev/null; then
    pkill -x "streamdeck"
    echo "Stream Deck instance killed."
    timeout=5
    elapsed=0
    while pgrep -x "streamdeck" > /dev/null && [ $elapsed -lt $timeout ]; do
        sleep 0.1
        elapsed=$(echo "$elapsed + 0.1" | bc)
    done
    if pgrep -x "streamdeck" > /dev/null; then
        echo "Force killing Stream Deck instance."
        pkill -9 -x "streamdeck"
    fi
fi


#!/bin/bash
if ! pgrep -x 'wofi' > /dev/null; then pkill -SIGUSR1 waybar; fi

#!/bin/bash

killall streamdeck
#killall -9 streamdeck
while pgrep streamdeck > /dev/null; do
    sleep 0.1
done

#!/usr/bin/env bash

cols=$(tput cols)
rows=$(tput lines)
# Display loading message

text=" Restoring tmux session..."
cols=$(tput cols)
rows=$(tput lines)

text_length=${#text}
col=$((($cols - $text_length) / 2))
row=$(($rows / 2))

# Clear screen and position cursor
# \033[H moves to home, \033[2J clears screen
# \033[row;colH moves to specific position
clear
echo -ne "\033[${row};${col}H${text}"
echo  # newline at the end

# Maximum iterations to wait (fallback in case detection fails)
# Each iteration is 0.3s, so ~33 iterations = ~10 seconds
MAX_ITERATIONS=33
iterations=0

# Initial count of panes
prev_count=$(tmux list-panes -a 2>/dev/null | wc -l)

# Wait a moment for resurrect to start
sleep 0.5

# Monitor until panes stop being created (resurrection is complete)
stable_count=0
while [ $iterations -lt $MAX_ITERATIONS ]; do
    sleep 0.3
    current_count=$(tmux list-panes -a 2>/dev/null | wc -l)

    # If pane count hasn't changed, increment stability counter
    if [ "$current_count" -eq "$prev_count" ]; then
        ((stable_count++))
        # If stable for 3 consecutive checks (0.9s), restoration is likely complete
        if [ $stable_count -ge 3 ]; then
            break
        fi
    else
        # Reset stability counter if count changed
        stable_count=0
        prev_count=$current_count
    fi

    ((iterations++))
done

# Small delay to ensure everything is settled
sleep 0.5
text="󰩐 Session restored!"

text_length=${#text}
col=$((($cols - $text_length) / 2))
row=$(($rows / 2))

# Clear screen and position cursor
# \033[H moves to home, \033[2J clears screen
# \033[row;colH moves to specific position
clear
echo -ne "\033[${row};${col}H${text}"
echo  # newline at the end


sleep 0.3

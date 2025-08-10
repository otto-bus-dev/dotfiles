#!/bin/bash

# Usage: ./replace_text.sh target_script.sh "text_to_replace" "replacement_text"

TARGET="/etc/grub.d/10_linux"

SEARCH="echo	'\$(echo \"\$message\" | grub_quote)'"
REPLACE=""

# Make a backup
cp "$TARGET" "${TARGET}.bak"

# Do the replacement (in-place)
sed -i "s/${SEARCH}/${REPLACE}/g" "$TARGET"


#!/usr/bin/env bash
# Start the SSH agent if not already running
eval "$(ssh-agent -s)"

# Optionally add your SSH key
if ! ssh-add -l &>/dev/null; then
    ssh-add ~/.ssh/github_rsa
fi

#!/usr/bin/env  bash
silent() { "$@" > /dev/null 2>&1; }

silent yay -S mono --noconfirm


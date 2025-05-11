#!/usr/bin/env  bash
silent() { "$@" > /dev/null 2>&1; }

silent yay -S reflector --noconfirm
silent sudo reflector --country France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
silent yay -Syy --noconfirm
silent yay -S blender --noconfirm

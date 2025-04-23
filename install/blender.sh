#!/usr/bin/env  bash
yay -S reflector --noconfirm
sudo reflector --country France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
yay -Syy --noconfirm
yay -S blender --noconfirm

#!/usr/bin/env  bash
source ~/dotfiles/install/utils/common.sh
REFLECTOR=(
  reflector
)
BLENDER=(
  blender 
)
install_packages "${REFLECTOR[@]}"
echo "updating mirror list"
silent sudo reflector --country France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
silent yay -Syy --noconfirm
install_packages "${BLENDER[@]}"

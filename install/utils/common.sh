#!/bin/bash
silent() { "$@" > /dev/null 2>&1; }

install_packages(){
	local packages=("$@")
	for package in "${packages[@]}"; do
    if pacman -Qq "${package}" &>/dev/null; then
      echo "  - ${package} is already installed."
      continue
    fi
    echo "  - install ${package}"
		silent yay -S --noconfirm ${package}
	done
}



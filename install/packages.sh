#!/bin/bash
SYSTEM_UTILITIES=(
	nm-applet
	nm-connection-editor
	bluez
	bluez-utils
	blueman
	nvidia
	nvidia-utils
	nvidia-settings
	nvidia-dkms
	jq
	stow
	tmux
	lazygit
)

DESKTOP=(
	greetd
	hyprland-git
	hyprlock
	hypridle
	swaync
	gtk4
	nwg-look
	waybar
	xdg-desktop-portal 
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	nautilus
	rose-pine-gtk-theme-full
)

APPS=(
	brave-bin
	neovim
	obsidian
)

install_packages(){
	local packages=("$@")
	echo "${packages[@]}"
	for package in "${packages[@]}"; do
		yay -S --noconfirm ${package}
	done
}

install_packages "${SYSTEM_UTILITIES[@]}"
install_packages "${DESKTOP[@]}"
install_packages "${APPS[@]}"



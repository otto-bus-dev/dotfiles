#!/bin/bash
SYSTEM_UTILITIES=(
	nm-applet
	nm-connection-editor
	bluez
	bluez-utils
  bluez-obex
	bluetuith
	nvidia-open
	nvidia-utils
	nvidia-settings
	nvidia-dkms
  cups
  brother-mfc-j5330dw
  pipewire
  pipewire-pulse
  wireplumber
  openssh
)

DESKTOP=(
  greetd
	hyprland-git
	hyprlock
	hypridle
	hyprpolkitagent
	hyprcursor
	hyprpaper
	swaync
	gtk4
	nwg-look
	waybar
	xdg-desktop-portal 
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	nautilus
	rose-pine-gtk-theme-full
  xclip
  wdisplays
  brightnessctl
  wofi
  plymouth
  streamdeck-ui
  seahorse
  networkmanager
  alsa-utils
)

APPS=(
	brave-bin
	obsidian
  blender
  unityhub
  thunderbird
  scratch
  vlc
)

TOOLS=(
	neovim
	tmux
  nodejs
  npm
  kitty
	lazygit
	jq
	stow
  luarocks
  lua51
  python-pip
  python-pynvim
  python-debugpy
  lynx
  dotnet-sdk
  dotnet-runtime-9.0
  aspnet-runtime-9.0
  stylua
  prettier
  fd
  imagemagick
  electron
  nfs-utils
  virtualbox
  virtualbox-host-modules-arch
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
install_packages "${TOOLS[@]}"


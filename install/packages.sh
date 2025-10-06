#!/bin/bash

source ~/dotfiles/install/utils/common.sh
SYSTEM_UTILITIES=(
	nm-applet
	nm-connection-editor
	bluez
	bluez-utils
  bluez-obex
	bluetuith
  cups
  brother-mfc-j5330dw
  pipewire
  pipewire-pulse
  wireplumber
  ddcutil
  openssh
  wlr-randr
)

DESKTOP=(
  greetd
  greetd-gtkgreet
	hyprland-git
	hyprlock
	hypridle
	hyprpolkitagent
	hyprcursor
	hyprpaper
	swaync
	gtk4
	waybar
	xdg-desktop-portal 
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	nautilus
	rose-pine-gtk-theme-full
  rose-pine-cursor
  xclip
  wdisplays
  brightnessctl
  wofi
  plymouth
  streamdeck-ui
  seahorse
  networkmanager
  alsa-utils
  slurp
  grim
  wl-clipboard
  neofetch
  nwg-look
  bitwarder-cli

)

APPS=(
	brave-bin
	obsidian
  thunderbird
  gimp
)

TOOLS=(
	neovim
	tmux
  nodejs
  npm
  kitty
	lazygit
	jq
  vi
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
  linux-headers
  wget
  ripgrep
  tree-sitter
  github-cli
  docker
  docker-compose
)

echo "install system utilities :"
install_packages "${SYSTEM_UTILITIES[@]}"
echo "install desktop :"
install_packages "${DESKTOP[@]}"
echo "install tools :"
install_packages "${TOOLS[@]}"
echo "install apps :"
install_packages "${APPS[@]}"


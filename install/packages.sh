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

silent() { "$@" > /dev/null 2>&1; }

install_packages(){
	local packages=("$@")
	for package in "${packages[@]}"; do
    if pacman -Qq "${package}" &>/dev/null; then
      echo "  - ${package} is already installed."
      continue
    fi
    echo "  - install ${package} is already installed."
		silent yay -S --noconfirm ${package}
	done
}

echo "install system utilities :"
install_packages "${SYSTEM_UTILITIES[@]}"
echo "install desktop :"
install_packages "${DESKTOP[@]}"
echo "install tools :"
install_packages "${TOOLS[@]}"
echo "install apps :"
install_packages "${APPS[@]}"


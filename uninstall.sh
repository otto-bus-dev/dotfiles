#!/bin/bash
yay -R xdg-desktop-portal xdg-desktop-portal-gtk
yay -R nautilus
yay -R rose-pine-gtk-theme-full
yay -R stow
yay -R hypridle
yay -R hyprlock
yay -R waybar
yay -R tmux
yay -R obsidian
yay -R gtk4
systemctl disable bluetooth.service
systemctl stop bluetooth.service
yay -Rns brave-bin
rm -rf ~/.config/yay-bin
sudo pacman -R neovim git base-devel bluez bluez-utils --noconfirm


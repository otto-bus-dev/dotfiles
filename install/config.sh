#!/bin/bash
git config --global user.email "otto.bus.dev@gmail.com"
git config --global user.name "otto"
#ssh-keygen -t ed25519 -C "otto.bus.dev@gmail.com"

source ~/dotfiles/install/files.sh

dotnet tool install -g csharpier

git clone https://github.com/tmux-plugins/tps ~/dotfiles/tmux/plugins/tpm

cd ~/dotfiles
stow bash
stow hypr
stow scripts
stow waybar
stow wofi
stow swaync
stow kitty
stow brave
stow tmux
stow nvim
cd ~

sudo plymouth-set-default-theme -R spinner
sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg

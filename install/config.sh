#!/bin/bash
git config --global user.email "otto.bus.dev@gmail.com"
git config --global user.name "otto"
ssh-keygen -t ed25519 -C "otto.bus.dev@gmail.com"

sudo ln -s ~/dotfiles/greetd/config.toml /etc/greetd/
sudo rm /etc/default/grub
sudo ln -s ~/dotfiles/grub/grub /etc/default/


cd ~/dotfiles
stow bash
stow hyrl
stow scritps
stow waybar
stow wofi
stow swaync
stow kitty
stow brave
cd ~


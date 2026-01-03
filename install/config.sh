#!/bin/bash
silent() { "$@" > /dev/null 2>&1; }

echo "setting up git global user config"
git config --global user.email $1
git config --global user.name $2

echo "installing packages"
silent dotnet tool install -g csharpier

echo "removing existing .bashrc file"
silent rm ~/.bashrc

echo "stowing dotfiles"
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
stow wallpapers
stow fonts
stow gtk
stow ssh
stow nushell
cd ~

echo "get tmux package manager"
silent git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/.config/tmux/plugins/tpm
echo "install tmux packages"
silent ~/.config/tmux/plugins/tpm/bin/install_plugins


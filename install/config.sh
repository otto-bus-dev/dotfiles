#!/bin/bash
silent() { "$@" > /dev/null 2>&1; }

echo "setting up git global user config"
git config --global user.email $1
git config --global user.name $2

echo "installing packages"
silent dotnet tool install -g csharpier

echo "installing stow"
silent git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/plugins/tpm

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
cd ~

echo "copy files for boot setup"
sudo cp ~/dotfiles/greetd/config.toml /etc/greetd/
sudo cp ~/dotfiles/etc/grub /etc/default/grub
sudo cp ~/dotfiles/usr/spinner.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth
sudo cp ~/dotfiles/usr/watermark.png /usr/share/plymouth/themes/spinner/watermark.png
sudo cp ~/dotfiles/etc/plymouthd.conf /etc/plymouth/plymouthd.conf

echo "rebuilding initramfs and grub"
silent sudo plymouth-set-default-theme -R spinner
silent sudo grub-mkconfig -o /boot/grub/grub.cfg

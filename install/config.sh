#!/bin/bash
git config --global user.email "otto.bus.dev@gmail.com"
git config --global user.name "otto"
#ssh-keygen -t ed25519 -C "otto.bus.dev@gmail.com"

sudo rm /etc/greetd/config.toml
sudo ln -s ~/dotfiles/greetd/config.toml /etc/greetd/
sudo rm /etc/default/grub
sudo ln -s ~/dotfiles/etc/grub /etc/default/grub
sudo rm /usr/share/plymouth/themes/spinner/spinner.plymouth
sudo ln -s ~/dotfiles/usr/spinner.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth
sudo ln -s ~/dotfiles/usr/watermark.png /usr/share/plymouth/themes/spinner/watermark.png



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

sudo grub-mkconfig -o /boot/grub/grub.cfg

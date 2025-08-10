#!/bin/bash
silent() { "$@" > /dev/null 2>&1; }

echo "set up  greetd conf"
sudo rm -rf /etc/greetd/
sudo mkdir /etc/greetd
sudo ln -s ~/dotfiles/greetd/config.toml /etc/greetd/config.toml
sudo ln -s ~/dotfiles/greetd/hyprland.conf /etc/greetd/hyprland.conf
sudo ln -s ~/dotfiles/hypr/.config/hypr/hyprland /etc/greetd/hyprland
sudo ln -s ~/dotfiles/hypr/.config/hypr/hyprpaper.conf /etc/greetd/hyprpaper.conf
sudo ln -s ~/dotfiles/scripts/.local/share/script/load_wallpaper.sh /etc/greetd/load_wallpaper.sh

echo "sudo rm /etc/default/grub"
sudo rm /etc/default/grub
echo "sudo ln -s ~/dotfiles/etc/grub /etc/default/grub"
sudo ln -s ~/dotfiles/etc/grub /etc/default/grub
echo "sudo rm /usr/share/plymouth/themes/spinner/spinner.plymouth"
sudo rm /usr/share/plymouth/themes/spinner/spinner.plymouth
echo "sudo cp ~/dotfiles/usr/spinner.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth"
sudo cp ~/dotfiles/usr/spinner.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth

echo "sudo rm /usr/share/plymouth/themes/spinner/watermark.png"
sudo rm /usr/share/plymouth/themes/spinner/watermark.png
echo "sudo cp ~/dotfiles/usr/watermark.png /usr/share/plymouth/themes/spinner/watermark.png"
sudo cp ~/dotfiles/usr/watermark.png /usr/share/plymouth/themes/spinner/watermark.png

echo "sudo rm /etc/plymouth/plymouthd.conf"
sudo rm /etc/plymouth/plymouthd.conf 
echo "sudo cp ~/dotfiles/etc/plymouthd.conf /etc/plymouth/plymouthd.conf"
sudo cp ~/dotfiles/etc/plymouthd.conf /etc/plymouth/plymouthd.conf

echo "sudo ~/dotfiles/install/update_grub_echos.sh"
sudo ~/dotfiles/install/update_grub_echos.sh

echo "rebuilding initramfs and grub"
silent sudo plymouth-set-default-theme -R spinner
silent sudo grub-mkconfig -o /boot/grub/grub.cfg
silent sudo mkinitcpio -P  # On Arch

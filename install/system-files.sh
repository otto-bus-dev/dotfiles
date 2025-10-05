#!/bin/bash
silent() { "$@" > /dev/null 2>&1; }

echo "sudo rm /usr/share/plymouth/themes/spinner/spinner.plymouth"
sudo rm /usr/share/plymouth/themes/spinner/spinner.plymouth
echo "sudo rm /usr/share/plymouth/themes/spinner/watermark.png"
sudo rm /usr/share/plymouth/themes/spinner/watermark.png
sudo cp ~/dotfiles/usr/share/plymouth/themes/spinner/watermark.png /usr/share/plymouth/themes/spinner/watermark.png
sudo cp ~/dotfiles/usr/share/plymouth/themes/spinner/spinner.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth

silent rm ~/.bashrc

echo "stowing dotfiles globals"
cd ~/dotfiles
sudo stow -t /etc etc
sudo stow -t /usr/share/ scripts
cd ~


echo "sudo ~/dotfiles/install/update_grub_echos.sh"
sudo ~/dotfiles/install/update_grub_echos.sh

echo "rebuilding initramfs and grub"
silent sudo plymouth-set-default-theme -R spinner
silent sudo grub-mkconfig -o /boot/grub/grub.cfg
silent sudo mkinitcpio -P  # On Arch

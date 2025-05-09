sudo rm /etc/greetd/config.toml
sudo cp ~/dotfiles/greetd/config.toml /etc/greetd/
sudo rm /etc/default/grub
sudo cp ~/dotfiles/etc/grub /etc/default/grub
sudo rm /usr/share/plymouth/themes/spinner/spinner.plymouth
sudo cp ~/dotfiles/usr/spinner.plymouth /usr/share/plymouth/themes/spinner/spinner.plymouth
sudo rm /usr/share/plymouth/themes/spinner/watermark.png
sudo cp ~/dotfiles/usr/watermark.png /usr/share/plymouth/themes/spinner/watermark.png
sudo rm /etc/plymouth/plymouthd.conf
sudo cp ~/dotfiles/etc/plymouthd.conf /etc/plymouth/plymouthd.conf
sudo rm /etc/sysctl.d/20-quiet-printk.conf
sudo cp ~/dotfiles/etc/20-quiet-printk.conf /etc/sysctl.d/20-quiet-printk.conf

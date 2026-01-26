#!/bin/bash
# System file deployment — desktop only (grub, plymouth, greetd, mkinitcpio)

deploy_system_files() {
    if is_wsl; then
        echo "WSL detected — skipping system file deployment (grub, plymouth, greetd)"
        return 0
    fi

    echo "======================================"
    echo "  Deploying system files"
    echo "======================================"

    local dotfiles_dir username
    dotfiles_dir="$(get_dotfiles_dir)"
    username="$(get_username)"

    if [[ "$DRY_RUN" == "1" ]]; then
        echo "  [dry-run] would deploy plymouth theme, greetd config (user=$username), grub, mkinitcpio"
        return 0
    fi

    # Plymouth theme
    echo "  - plymouth theme"
    sudo rm -f /usr/share/plymouth/themes/spinner/spinner.plymouth
    sudo rm -f /usr/share/plymouth/themes/spinner/watermark.png
    sudo cp "$dotfiles_dir/usr/share/plymouth/themes/spinner/watermark.png" \
            /usr/share/plymouth/themes/spinner/watermark.png
    sudo cp "$dotfiles_dir/usr/share/plymouth/themes/spinner/spinner.plymouth" \
            /usr/share/plymouth/themes/spinner/spinner.plymouth

    # Greetd config — template the username
    echo "  - greetd config (user=$username)"
    sudo mkdir -p /etc/greetd
    sed "s/user = \"otto\"/user = \"$username\"/" \
        "$dotfiles_dir/etc/greetd/config.toml" | \
        sudo tee /etc/greetd/config.toml > /dev/null
    sudo cp "$dotfiles_dir/etc/greetd/hyprland.conf" /etc/greetd/hyprland.conf
    sudo cp "$dotfiles_dir/etc/greetd/hypridle.conf" /etc/greetd/hypridle.conf

    # Stow etc and scripts to system dirs
    echo "  - stow /etc and /usr/share"
    cd "$dotfiles_dir"
    sudo stow -t /etc etc
    sudo stow -t /usr/share/ scripts
    cd - > /dev/null

    # Remove default bashrc if it exists and is not a symlink
    if [[ -f "$HOME/.bashrc" && ! -L "$HOME/.bashrc" ]]; then
        echo "  - removing default .bashrc"
        rm "$HOME/.bashrc"
    fi

    # Grub and initramfs
    echo "  - grub and initramfs"
    sudo "$dotfiles_dir/install/update_grub_echos.sh"
    silent sudo plymouth-set-default-theme -R spinner
    silent sudo grub-mkconfig -o /boot/grub/grub.cfg
    silent sudo mkinitcpio -P
}

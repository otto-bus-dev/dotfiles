#!/bin/bash
# GPU detection and driver installation — desktop only

install_graphics() {
    if is_wsl; then
        echo "WSL detected — skipping graphics driver installation"
        return 0
    fi

    echo "======================================"
    echo "  Graphics driver setup"
    echo "======================================"

    local gpu="None"

    if lspci | grep -qi "NVIDIA"; then
        gpu="NVIDIA"
        echo "  Detected: NVIDIA GPU"
    elif lspci | grep -qi "Intel"; then
        gpu="Intel"
        echo "  Detected: Intel GPU"
    else
        echo "  No compatible GPU detected"
        return 0
    fi

    local dotfiles_dir
    dotfiles_dir="$(get_dotfiles_dir)"

    if [[ "$DRY_RUN" == "1" ]]; then
        echo "  [dry-run] would install $gpu drivers"
        return 0
    fi

    case "$gpu" in
        "NVIDIA")
            echo "  - installing NVIDIA drivers"
            silent yay -S --noconfirm nvidia-open nvidia-utils nvidia-settings
            sudo ln -sf "$dotfiles_dir/install/graphics/mkinitcpio.nvidia.conf" /etc/mkinitcpio.conf
            ;;
        "Intel")
            echo "  - installing Intel drivers"
            silent yay -S --noconfirm xf86-video-intel
            sudo ln -sf "$dotfiles_dir/install/graphics/mkinitcpio.intel.conf" /etc/mkinitcpio.conf
            ;;
    esac
}

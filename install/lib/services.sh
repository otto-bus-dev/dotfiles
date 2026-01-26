#!/bin/bash
# Systemd service management — conditional on environment

enable_services() {
    echo "======================================"
    echo "  Enabling services"
    echo "======================================"

    if [[ "$DRY_RUN" == "1" ]]; then
        echo "  [dry-run] would enable docker"
        is_desktop && echo "  [dry-run] would enable desktop services (bluetooth, hyprpaper, NetworkManager, greetd, cups)"
        return 0
    fi

    # Services for all environments
    echo "  - docker"
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker "$USER"

    if is_desktop; then
        echo "  - bluetooth"
        sudo systemctl enable bluetooth.service
        sudo systemctl start bluetooth.service

        echo "  - hyprpaper (user)"
        systemctl --user enable --now hyprpaper.service

        echo "  - NetworkManager"
        sudo systemctl enable NetworkManager
        sudo systemctl start NetworkManager

        echo "  - greetd"
        sudo systemctl enable greetd

        echo "  - cups"
        sudo systemctl enable --now cups.service
        sudo systemctl start cups.service

        echo "  - greetd (start)"
        sudo systemctl start greetd
    else
        echo "  WSL detected — skipping desktop services"
    fi
}

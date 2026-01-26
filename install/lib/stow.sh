#!/bin/bash
# Stow management — conditional on environment

TERMINAL_STOW_PACKAGES=(bat git nushell nvim scripts ssh tmux fonts)
DESKTOP_STOW_PACKAGES=(hypr waybar wofi swaync kitty autostart wallpapers gtk pipewire)

stow_packages() {
    local dotfiles_dir
    dotfiles_dir="$(get_dotfiles_dir)"
    cd "$dotfiles_dir" || exit 1

    echo "======================================"
    echo "  Stowing terminal packages"
    echo "======================================"
    for pkg in "${TERMINAL_STOW_PACKAGES[@]}"; do
        if [[ -d "$pkg" ]]; then
            echo "  - stow $pkg"
            if [[ "$DRY_RUN" != "1" ]]; then
                stow --restow "$pkg"
            fi
        else
            echo "  - skip $pkg (directory not found)"
        fi
    done

    if is_desktop; then
        echo "======================================"
        echo "  Stowing desktop packages"
        echo "======================================"
        for pkg in "${DESKTOP_STOW_PACKAGES[@]}"; do
            if [[ -d "$pkg" ]]; then
                echo "  - stow $pkg"
                if [[ "$DRY_RUN" != "1" ]]; then
                    stow --restow "$pkg"
                fi
            else
                echo "  - skip $pkg (directory not found)"
            fi
        done
    else
        echo "WSL detected — skipping desktop stow packages"
    fi

    cd - > /dev/null
}

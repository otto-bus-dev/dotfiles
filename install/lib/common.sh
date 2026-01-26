#!/bin/bash
# Shared utility functions

silent() { "$@" > /dev/null 2>&1; }

install_packages() {
    local packages=("$@")
    for package in "${packages[@]}"; do
        if pacman -Qq "${package}" &>/dev/null; then
            echo "  - ${package} is already installed."
            continue
        fi
        echo "  - installing ${package}"
        if [[ "$DRY_RUN" == "1" ]]; then
            echo "  [dry-run] would install ${package}"
        else
            silent yay -S --noconfirm "${package}"
        fi
    done
}

pip_install() {
    local packages=("$@")
    for package in "${packages[@]}"; do
        if pip show "${package}" &>/dev/null; then
            echo "  - ${package} (pip) is already installed."
            continue
        fi
        echo "  - installing ${package} (pip)"
        if [[ "$DRY_RUN" == "1" ]]; then
            echo "  [dry-run] would pip install ${package}"
        else
            pip install --user "${package}"
        fi
    done
}

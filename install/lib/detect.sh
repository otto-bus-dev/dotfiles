#!/bin/bash
# Environment detection utilities

is_wsl() {
    [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]
}

is_desktop() {
    ! is_wsl
}

get_username() {
    whoami
}

get_dotfiles_dir() {
    echo "${DOTFILES_DIR:-$HOME/dotfiles}"
}

print_env_banner() {
    echo ""
    echo "======================================"
    if is_wsl; then
        echo "  Environment: WSL ($WSL_DISTRO_NAME)"
        echo "  Mode: Terminal only"
    else
        echo "  Environment: Bare-metal Arch"
        echo "  Mode: Full desktop + terminal"
    fi
    echo "  User: $(get_username)"
    echo "  Dotfiles: $(get_dotfiles_dir)"
    echo "======================================"
    echo ""
}

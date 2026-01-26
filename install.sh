#!/bin/bash
set -euo pipefail

# ====================================
# Dotfiles Installer
# Detects WSL vs bare-metal and acts accordingly
# ====================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DRY_RUN="${DRY_RUN:-0}"

# Source all library modules
source "$SCRIPT_DIR/install/lib/detect.sh"
source "$SCRIPT_DIR/install/lib/common.sh"
source "$SCRIPT_DIR/install/lib/packages.sh"
source "$SCRIPT_DIR/install/lib/stow.sh"
source "$SCRIPT_DIR/install/lib/services.sh"
source "$SCRIPT_DIR/install/lib/system-files.sh"
source "$SCRIPT_DIR/install/lib/graphics.sh"
source "$SCRIPT_DIR/install/lib/data-tools.sh"

# ====================================
# Sudo keep-alive
# ====================================
setup_sudo() {
    echo "Requesting sudo access..."
    sudo -v
    while true; do sudo -n true; sleep 60; done 2>/dev/null &
    SUDO_PID=$!
    trap "kill $SUDO_PID 2>/dev/null" EXIT
}

# ====================================
# Git configuration
# ====================================
setup_git() {
    # Skip if already configured via .gitconfig.local
    if [[ -f "$HOME/.gitconfig.local" ]]; then
        echo "Git user config already exists (~/.gitconfig.local) — skipping"
        return 0
    fi

    echo "======================================"
    echo "  Git Global User Config"
    echo "======================================"
    read -p "  Enter your git user mail: " git_user_mail
    read -p "  Enter your git user name: " git_user_name

    if [[ "$DRY_RUN" != "1" ]]; then
        mkdir -p "$(dirname "$HOME/.gitconfig.local")"
        cat > "$HOME/.gitconfig.local" << GITEOF
[user]
    email = $git_user_mail
    name = $git_user_name
GITEOF
        echo "  Saved to ~/.gitconfig.local"
    else
        echo "  [dry-run] would create ~/.gitconfig.local"
    fi
}

# ====================================
# Tmux plugin manager
# ====================================
setup_tpm() {
    local tpm_dir
    tpm_dir="$(get_dotfiles_dir)/tmux/.config/tmux/plugins/tpm"

    if [[ -d "$tpm_dir" ]]; then
        echo "TPM already installed — skipping"
        return 0
    fi

    echo "  - cloning TPM"
    if [[ "$DRY_RUN" != "1" ]]; then
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        echo "  - installing tmux plugins"
        "$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
    else
        echo "  [dry-run] would clone TPM and install plugins"
    fi
}

# ====================================
# Remove default .bashrc if not a symlink
# ====================================
cleanup_bashrc() {
    if [[ -f "$HOME/.bashrc" && ! -L "$HOME/.bashrc" ]]; then
        echo "  - removing default .bashrc"
        if [[ "$DRY_RUN" != "1" ]]; then
            rm "$HOME/.bashrc"
        fi
    fi
}

# ====================================
# Full install
# ====================================
run_full() {
    print_env_banner
    setup_sudo

    # 1. Git config
    setup_git

    # 2. YAY (AUR helper)
    echo "======================================"
    echo "  Installing YAY"
    echo "======================================"
    if [[ "$DRY_RUN" != "1" ]]; then
        "$SCRIPT_DIR/install/yay.sh"
    else
        echo "  [dry-run] would install yay"
    fi

    # 3. Packages
    install_core_packages
    install_desktop_packages

    # 4. Graphics drivers (desktop only)
    install_graphics

    # 5. Stow configs
    cleanup_bashrc
    stow_packages

    # 6. TPM (tmux plugin manager)
    setup_tpm

    # 7. Dotnet tools
    echo "  - installing csharpier"
    if [[ "$DRY_RUN" != "1" ]]; then
        silent dotnet tool install -g csharpier || true
    fi

    # 8. System files (desktop only)
    deploy_system_files

    # 9. Services
    enable_services

    # 10. Data engineering tools (interactive)
    select_data_tools

    echo ""
    echo "======================================"
    echo "  Installation complete!"
    echo "======================================"
}

# ====================================
# Usage
# ====================================
usage() {
    echo "Usage: ./install.sh <command> [--dry-run]"
    echo ""
    echo "Commands:"
    echo "  full          Full install (detects WSL vs bare-metal)"
    echo "  packages      Install packages only"
    echo "  config        Stow configs only"
    echo "  services      Enable services only"
    echo "  system-files  Deploy system files only (desktop)"
    echo "  graphics      Install graphics drivers only (desktop)"
    echo "  data-tools    Interactive data engineering tool selector"
    echo "  git           Configure git user"
    echo "  boot          Deploy system files (alias)"
    echo "  app <name>    Install specific app (blender, unity, scratch, rust, pygame)"
    echo ""
    echo "Options:"
    echo "  --dry-run     Print what would happen without executing"
}

# ====================================
# Parse arguments
# ====================================

# Check for --dry-run flag
for arg in "$@"; do
    if [[ "$arg" == "--dry-run" ]]; then
        export DRY_RUN="1"
        echo "[DRY RUN MODE]"
    fi
done

# Get the command (first non-flag argument)
CMD="${1:-}"

case "$CMD" in
    full)
        run_full
        ;;
    packages)
        setup_sudo
        print_env_banner
        install_core_packages
        install_desktop_packages
        ;;
    config)
        print_env_banner
        cleanup_bashrc
        stow_packages
        setup_tpm
        ;;
    services)
        setup_sudo
        print_env_banner
        enable_services
        ;;
    system-files|boot)
        setup_sudo
        print_env_banner
        deploy_system_files
        ;;
    graphics)
        setup_sudo
        print_env_banner
        install_graphics
        ;;
    data-tools)
        print_env_banner
        select_data_tools
        ;;
    git)
        setup_git
        ;;
    app)
        APP="${2:-}"
        case "$APP" in
            blender)  "$SCRIPT_DIR/install/apps/blender.sh" ;;
            unity)    "$SCRIPT_DIR/install/apps/unity.sh" ;;
            scratch)  "$SCRIPT_DIR/install/apps/scratch.sh" ;;
            rust)     "$SCRIPT_DIR/install/apps/rust.sh" ;;
            pygame)   "$SCRIPT_DIR/install/apps/pygame.sh" ;;
            *)
                echo "Unknown app: $APP"
                echo "Available: blender, unity, scratch, rust, pygame"
                exit 1
                ;;
        esac
        ;;
    --dry-run)
        # --dry-run passed as first arg without a command
        echo "Please specify a command. Example: ./install.sh full --dry-run"
        usage
        exit 1
        ;;
    "")
        usage
        ;;
    *)
        echo "Unknown command: $CMD"
        usage
        exit 1
        ;;
esac

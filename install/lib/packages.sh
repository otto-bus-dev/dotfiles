#!/bin/bash
# Package definitions split by environment

# Terminal tools — installed on all environments
CORE_PACKAGES=(
    # Shell & terminal
    nushell
    fzf
    bat
    ripgrep
    fd
    jq
    htop
    wget
    stow
    openssh
    # Editor
    neovim
    tree-sitter
    tree-sitter-cli
    # Dev tools
    tmux
    lazygit
    git
    github-cli
    nodejs
    npm
    python-pip
    python-pynvim
    python-debugpy
    # Languages & runtimes
    dotnet-sdk
    dotnet-runtime-9.0
    aspnet-runtime-9.0
    luarocks
    lua51
    # Formatters & linters
    stylua
    prettier
    # Containers
    docker
    docker-compose
    # Misc
    imagemagick
    lynx
    vi
)

# Desktop-only packages — skipped on WSL
DESKTOP_PACKAGES=(
    # System utilities
    nm-applet
    nm-connection-editor
    bluez
    bluez-utils
    bluez-obex
    bluetuith
    cups
    brother-mfc-j5330dw
    pipewire
    pipewire-pulse
    wireplumber
    ddcutil
    wlr-randr
    networkmanager
    alsa-utils
    # Hyprland desktop
    greetd
    greetd-gtkgreet
    hyprland
    hyprlock
    hypridle
    hyprpolkitagent
    hyprcursor
    hyprpaper
    # UI & theming
    swaync
    gtk4
    waybar
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    nautilus
    rose-pine-gtk-theme-full
    rose-pine-cursor
    nwg-look
    # Desktop tools
    xclip
    wdisplays
    brightnessctl
    wofi
    plymouth
    streamdeck-ui
    seahorse
    slurp
    grim
    wl-clipboard
    neofetch
    # Terminal emulator (desktop only — WSL uses Windows Terminal)
    kitty
    # Desktop apps
    brave-bin
    obsidian
    thunderbird
    gimp
    # Hardware & VM
    electron
    nfs-utils
    virtualbox
    virtualbox-host-modules-arch
    linux-headers
    # Homelab tools
    pvetui
    lazyssh
    bitwarder-cli
)

install_core_packages() {
    echo "======================================"
    echo "  Installing core packages"
    echo "======================================"
    install_packages "${CORE_PACKAGES[@]}"
}

install_desktop_packages() {
    if is_wsl; then
        echo "WSL detected — skipping desktop packages"
        return 0
    fi
    echo "======================================"
    echo "  Installing desktop packages"
    echo "======================================"
    install_packages "${DESKTOP_PACKAGES[@]}"
}

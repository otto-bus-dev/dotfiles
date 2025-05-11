#!/bin/bash
silent() { "$@" > /dev/null 2>&1; }

# Function to check if yay is installed
is_yay_installed() {
    command -v yay &> /dev/null
}

# Function to install yay
install_yay() {
    echo "Installing yay..."
    
    # Install required dependencies
    silent sudo pacman -Sy --needed --noconfirm git base-devel

    # Clone the yay repository
    silent git clone https://aur.archlinux.org/yay.git

    # Change directory to yay
    cd yay || exit

    # Build and install yay
    silent makepkg -si --noconfirm

    # Return to the original directory and clean up
    cd ..
    rm -rf yay

    echo "yay installed successfully!"
}

# Check if yay is already installed
if is_yay_installed; then
    echo "yay is already installed."
else
    install_yay
fi

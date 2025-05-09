nc#!/bin/bash

# Function to detect the GPU
detect_gpu() {
    echo "Detecting GPU..."
    if lspci | grep -i "NVIDIA" > /dev/null; then
        echo "Detected NVIDIA GPU"
        GPU="NVIDIA"
    elif lspci | grep -i "Intel" > /dev/null; then
        echo "Detected Intel GPU"
        GPU="Intel"
    else
        echo "No compatible GPU detected or GPU not supported"
        GPU="None"
    fi
}

# Function to install NVIDIA drivers
install_nvidia_driver() {
    echo "Installing NVIDIA drivers..."
    yay -S --noconfirm nvidia-open nvidia-utils	nvidia-settings nvidia-dkms
    sudo cp ~/dotfiles/etc/mkinitcpio.nvidia.conf /etc/mkinitcpio.conf
}

# Function to install Intel drivers
install_intel_driver() {
    echo "Installing Intel drivers..."
    yay -S --noconfirm xf86-video-intel
    sudo cp ~/dotfiles/etc/mkinitcpio.conf /etc/mkinitcpio.conf
}

# Main script logic
main() {
    detect_gpu

    case $GPU in
        "NVIDIA")
            install_nvidia_driver
            ;;
        "Intel")
            install_intel_driver
            ;;
        "None")
            echo "No drivers installed. Exiting."
            ;;
    esac
}

# Execute the main function
main

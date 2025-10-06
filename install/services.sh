#!/bin/bash
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
systemctl --user enable --now hyprpaper.service
sudo systemctl enable NetworkManager 
sudo systemctl start NetworkManager 
sudo systemctl enable greetd
sudo systemctl enable --now cups.service
sudo systemctl start cups.service
sudo systemctl start greetd
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

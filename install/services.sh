#!/bin/bash
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
systemctl --user enable --now hyprpaper.service
sudo systemctl enable NetworkManager 
sudo systemctl start NetworkManager 
sudo systemctl enable greetd.service

#!/bin/bash
systemctl start greetd.service
systemctl enable greetd.service
systemctl start bluetooth.service
systemctl enable bluetooth.service
systemctl --user enable --now hyprpaper.service
systemctl --user enable pipewire.service
systemctl --user start pipewire.service
systemctl --user enable wireplumber.service
systemctl --user start wireplumber.service

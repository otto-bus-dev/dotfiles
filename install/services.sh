#!/bin/bash
systemctl start greetd.service
systemctl enable greetd.service
systemctl start bluetooth.service
systemctl enable bluetooth.service
systemctl --user enable --now hyprpaper.service

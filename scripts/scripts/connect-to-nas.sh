#!/bin/bash

SHARED_FOLDER=(
  retropie
  video
  photo
  SSII
  scan
)

# Create all mount directories using the SHARED_FOLDER array
mkdir -p ~/mount
mkdir -p ~/mount/nas
for folder in "${SHARED_FOLDER[@]}"; do
  mkdir -p ~/mount/nas/"$folder"
done

# Backup fstab first
cp /etc/fstab /etc/fstab.bak

add_shared_folder(){
  for folder in "${SHARED_FOLDER[@]}"; do
    # Check if line exists (searching for the whole mount line)
    if grep -Fxq "nas:/volume1/$folder /home/otto/mount/nas/$folder nfs   rw,user,_netdev,x-systemd.automount   0 0" /etc/fstab; then
      echo "Line for $folder already exists in /etc/fstab. No changes made."
    else
      echo "nas:/volume1/$folder /home/otto/mount/nas/$folder nfs   rw,user,_netdev,x-systemd.automount   0 0" | tee -a /etc/fstab
      echo "Line for $folder appended. Please verify /etc/fstab before rebooting!"
    fi
  done
}

add_shared_folder

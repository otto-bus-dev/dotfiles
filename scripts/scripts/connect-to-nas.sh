#!/bin/bash
set -e  # Exit on error

SHARED_FOLDER=(
  retropie
  video
  photo
  SSII
  scan
)

NAS_HOST="nas"
USER_HOME="${HOME}"

# Check if running with sudo (needed for fstab modification)
if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run with sudo"
  exit 1
fi

# Check if NAS is reachable
echo "Checking if NAS is reachable..."
if ! ping -c 1 -W 2 "$NAS_HOST" &>/dev/null; then
  echo "Error: Cannot reach NAS host '$NAS_HOST'. Please check network connection."
  exit 1
fi
echo "✓ NAS is reachable"

# Create all mount directories
echo "Creating mount directories..."
if ! mkdir -p "$USER_HOME/mount/nas"; then
  echo "Error: Failed to create mount directory"
  exit 1
fi

for folder in "${SHARED_FOLDER[@]}"; do
  if ! mkdir -p "$USER_HOME/mount/nas/$folder"; then
    echo "Error: Failed to create directory for $folder"
    exit 1
  fi
done
echo "✓ Mount directories created"

# Backup fstab with timestamp if not already backed up
BACKUP_FILE="/etc/fstab.bak.$(date +%Y%m%d_%H%M%S)"
if [ ! -f "/etc/fstab.bak" ]; then
  if ! cp /etc/fstab "$BACKUP_FILE"; then
    echo "Error: Failed to backup /etc/fstab"
    exit 1
  fi
  ln -sf "$BACKUP_FILE" /etc/fstab.bak
  echo "✓ Backed up /etc/fstab to $BACKUP_FILE"
fi

add_shared_folder(){
  local added=0
  for folder in "${SHARED_FOLDER[@]}"; do
    local mount_line="$NAS_HOST:/volume1/$folder $USER_HOME/mount/nas/$folder nfs   rw,user,_netdev,x-systemd.automount   0 0"

    # Check if line exists
    if grep -Fxq "$mount_line" /etc/fstab; then
      echo "  ✓ $folder already in /etc/fstab"
    else
      if echo "$mount_line" >> /etc/fstab; then
        echo "  + Added $folder to /etc/fstab"
        ((added++))
      else
        echo "  ✗ Failed to add $folder to /etc/fstab"
        exit 1
      fi
    fi
  done

  if [ $added -gt 0 ]; then
    echo "✓ Added $added new mount(s) to /etc/fstab"
    echo "  Run 'sudo systemctl daemon-reload && sudo mount -a' to mount them now"
  else
    echo "✓ All mounts already configured"
  fi
}

add_shared_folder

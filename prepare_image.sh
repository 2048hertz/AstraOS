#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Automatically detect the boot and root partitions
boot_path=$(findmnt -rn -o TARGET -S LABEL=boot)
root_path=$(findmnt -rn -o TARGET -S LABEL=rootfs)

# Check if partitions were found
if [ -z "$boot_path" ] || [ -z "$root_path" ]; then
  echo "Could not find the boot or rootfs partitions. Please ensure the SD card is inserted and mounted."
  exit 1
fi

# Path to the existing installer script
existing_install_script="/usr/bin/RobertOS-assets/installer_script.sh"

# Make the installer script executable
chmod +x $existing_install_script

# Modify rc.local to run the installer script on boot
if ! grep -q "$existing_install_script" /etc/rc.local; then
  sed -i '/^exit 0/i '$existing_install_script'' /etc/rc.local
fi

# Enable SSH (optional)
touch $boot_path/ssh

echo "Image preparation complete. You can now safely unmount the SD card and boot your Raspberry Pi."
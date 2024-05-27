#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Path to the existing installer script
existing_install_script="/usr/bin/RobertOS-assets/installer_script.sh"

# Ensure the installer script is executable
chmod +x $existing_install_script

# Modify rc.local to run the installer script on boot
if ! grep -q "$existing_install_script" /etc/rc.local; then
  sed -i '/^exit 0/i '$existing_install_script'' /etc/rc.local
fi

# Enable SSH (optional)
touch /boot/ssh

echo "Setup script configuration complete. The system will run the installer script on next boot."
echo "Please shut down, remove the SD card, and follow the instructions to create an ISO image."

# Function to create an ISO image from the SD card
create_iso() {
  local sd_card_device=$1
  local iso_output=$2

  echo "Creating image file from SD card..."
  sudo dd if=$sd_card_device of=custom_raspberry_pi_os.img bs=4M status=progress

  echo "Converting image file to ISO..."
  sudo genisoimage -o $iso_output -V "CUSTOM_PI_OS" -J -r custom_raspberry_pi_os.img

  echo "ISO image creation complete: $iso_output"
}

# Function to identify the SD card device
identify_sd_card() {
  echo "Identifying SD card device..."
  local devices=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E "disk|part" | grep -v "loop")
  echo "$devices"
  echo
  echo "Please enter the device name of your SD card (e.g., /dev/sdX):"
  read sd_card_device
  echo

  if [ ! -b $sd_card_device ]; then
    echo "Invalid device. Please make sure the SD card is inserted and try again."
    exit 1
  fi

  echo "Device $sd_card_device identified."
  echo $sd_card_device
}

# Main process
if [ "$1" == "--create-iso" ]; then
  sd_card_device=$(identify_sd_card)
  create_iso $sd_card_device "astraOS.iso"
else
  echo "To create an ISO image, rerun this script with the --create-iso option after shutting down and inserting the SD card into your computer."
fi

echo "Setup complete. Please shut down the system, remove the SD card, and run this script with the --create-iso option on your computer to create the ISO image."

# Optionally, shut down the system automatically
# shutdown -h now
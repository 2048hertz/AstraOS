#! bin/bash
# Welcome to the Robert Computer Operating System build script 1
# The series of scripts made here should be used on Raspberry Pi OS to build Robert OS
# Version Teddy-Bear LTS V1
# Written by Ayaan Eusufzai/2048hertz of Gevox/Azak/RTD
# Please make sure you have the correct version of Raspberry Pi OS which this script is made for, the latest version of the base operating system will be installed automatically from the script
# Started: 7/5/24 1:28 AM Bangladesh Time

sudo apt install -y xfce4 xfce4-terminal xfce4-goodies firefox

# Light DM Configuration Update

cd /etc/lightdm
sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak 
sed -i 's/^user-session=.*/user-session=xfce/' /etc/lightdm/lightdm.conf
sed -i 's/^greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
cd

# Main 

sudo apt update -y && sudo apt upgrade -y
sudo apt remove chromium -y
sudo apt full-upgrade -y
sudo apt install -y flatpak
sudo flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install -y snap
sudo snap install -y core
sudo apt install -y git
sudo apt-get install -y python3-gi
# Edit /boot/cmdline.txt
#!/bin/bash

# Function to disable Raspberry Pi splash screen
disable_splash_screen() {
    # Edit the boot configuration file to disable the splash screen
    echo "Disabling Raspberry Pi splash screen..."
    echo "disable_splash=1" | sudo tee -a /boot/config.txt > /dev/null
}

# Function to grant sudo privileges
grant_sudo_privileges() {
    # Add the user to the sudo group
    echo "Granting sudo privileges..."
    sudo usermod -aG sudo $USER
}

# Check if user has sudo privileges
if [ "$(id -u)" -ne 0 ]; then
    grant_sudo_privileges
fi

# Call function to disable splash screen
disable_splash_screen

echo "Splash screen disabled. You can reboot later to apply changes."

# Check for /boot/config.txt (Optional for some Raspberry Pi versions)
if [ -f /boot/config.txt ]; then
  echo "Editing /boot/config.txt..."
  # Check if disable_splash is already set
  if grep -q "^disable_splash=1" /boot/config.txt; then
    echo "disable_splash=1 already exists."
  else
    # Add disable_splash=1 if not present
    sudo echo "disable_splash=1" >> /boot/config.txt
  fi
fi

# Check if cron is installed
if ! command -v cron &> /dev/null; then
    echo "Cron is not installed, installing cron"
    sudo apt update
    sudo apt install -y cron
    echo "Cron installed successfully."
fi

# Define the path to the script to be executed
script_path="/home/RobertOS-assets/phase2.sh"

# Make the script executable
chmod +x "$script_path"

# Add cron job to run the script at reboot
(crontab -l ; echo "@reboot $script_path") | crontab -

echo "Cron job set up to run '$script_path' at reboot."

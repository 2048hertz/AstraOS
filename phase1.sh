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

echo "Splash screen disabled."

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

# Define the path to the script to be executed
script_path="/home/RobertOS-assets/phase2.sh"

# Make the script executable
chmod +x "$script_path"

# Create a new service unit file for phase2
phase2_service_path="/etc/systemd/system/phase2.service"

# Write phase2 service content to the file
sudo tee "$phase2_service_path" > /dev/null <<EOL
[Unit]
Description=Phase 2 Script
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/bash $script_path

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable the phase2 service
sudo systemctl enable --now phase2.service

echo "Phase 2 service enabled. It will run the script $script_path once after booting, then disable itself."

sudo reboot

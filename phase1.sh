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

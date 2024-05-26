#!/bin/bash
# Welcome to the Robert Operating System build script 1; the name is not final.
# The series of scripts made here should be used on Raspberry Pi OS to build Robert OS
# Version Teddy-Bear V1
# Written by Ayaan Eusufzai/2048hertz
# Please make sure you have the correct version of Raspberry Pi OS which this script is made for, the latest version of the base operating system will be installed automatically from the script
# Started: 7/5/24 1:28 AM Bangladesh Time

sudo apt install -y xfce4 xfce4-terminal xfce4-goodies firefox

# Light DM Configuration Update

cd /etc/lightdm
sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak 
sed -i 's/^user-session=.*/user-session=xfce4-session/' /etc/lightdm/lightdm.conf
sed -i 's/^greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
sed -i 's/^autologin-session=.*/autologin-session=xfce4-session/' /etc/lightdm/lightdm.conf
cd

# Main 

sudo apt update -y && sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt remove chromium -y
# Addition of pi-apps
git clone https://github.com/Botspot/pi-apps && ~/pi-apps/install
sudo apt install -y flatpak
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo apt install -y snap
sudo snap install -y core
sudo apt install -y git build-essential cmake
sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
sudo apt update && sudo apt install box64 -y
sudo sh /usr/bin/RobertOS-assets/rpi-overclock.sh
sudo git clone https://github.com/AdnanHodzic/auto-cpufreq.git
sudo cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo apt-get install -y python3-gi
sudo apt remove -y eom
sudo apt remove -y desktop-base
sudo apt install -y network-manager-gnome
sudo apt install -y aisleriot
sudo apt install -y gnome-chess
sudo apt install -y four-in-a-row
sudo apt install -y libreoffice

# Edit /boot/cmdline.txt

# Function to disable Raspberry Pi splash screen
disable_splash_screen() {
  # Edit the boot configuration file to disable the splash screen
  echo "Disabling Raspberry Pi splash screen..."
  echo "disable_splash=1" | sudo tee -a /boot/firmware/config.txt
}

# Call function to disable splash screen
disable_splash_screen

echo "Splash screen disabled."
echo "Please run the command 'sudo sh /usr/bin/RobertOS-assets/phase2.sh' after reboot, automatically rebooting in 5 seconds."
sleep 5
sudo reboot

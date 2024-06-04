#!/bin/bash
# Written by Ayaan Eusufzai

# Clone the Orchis theme repository
sudo git clone https://github.com/vinceliuice/Orchis-theme.git

# Get variables for xfconf-query
read -p "Enter your current RpiOS username: " baseuser

# Install necessary dependencies for building the theme
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc software-properties-common

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh --tweaks solid

# Add the Numix PPA and install the Numix Square icon theme
sudo apt-get install -y dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1DCBDC01F9BA0ADA || true
echo "deb http://ppa.launchpad.net/numix/ppa/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/numix-ppa.list
sudo apt-get update -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true
sudo apt-get install --allow-unauthenticated -y numix-icon-theme numix-icon-theme-square

# Use xfconf-query to change settings
sudo -u $baseuser xfconf-query -c xsettings -p /Net/ThemeName -s "Orchis-Dark"
sudo -u $baseuser xfconf-query -c xsettings -p /Net/IconThemeName -s "Numix-Square"

echo "Please reboot the system to apply all changes"

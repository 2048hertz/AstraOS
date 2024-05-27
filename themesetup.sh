#!/bin/bash
# Written by Ayaan Eusufzai

# Clone the Orchis theme repository
git clone https://github.com/vinceliuice/Orchis-theme.git

# Install necessary dependencies for building the theme
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc software-properties-common

# Add the Numix PPA and install the Numix Square icon theme
sudo apt-get install -y dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1DCBDC01F9BA0ADA || true
echo "deb http://ppa.launchpad.net/numix/ppa/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/numix-ppa.list
sudo apt-get update -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true
sudo apt-get install --allow-unauthenticated -y numix-icon-theme numix-icon-theme-square

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh --tweaks solid

# Copy the new xsettings.xml to the destination directory, completely replacing the old file
cp /usr/bin/AstraOS-assets/xsettings.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml

echo "Please reboot the system to apply all changes"

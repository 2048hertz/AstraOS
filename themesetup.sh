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
sudo apt-get install -y numix-icon-theme numix-icon-theme-square

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh --tweaks solid

# Define the path of the new xsettings.xml
new_xsettings_file="/usr/bin/RobertOS-assets/xsettings.xml"

# Define the destination path for xsettings.xml in the home directory
xfce_config_dir="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml"
xfce_config_file="$xfce_config_dir/xsettings.xml"

# Copy the new xsettings.xml to the destination directory, completely replacing the old file
cp -f "$new_xsettings_file" "$xfce_config_file"

echo "Please reboot the system to apply all changes"

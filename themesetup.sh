#!/bin/bash
# Written by Ayaan Eusufzai

# Clone the Orchis theme repository
git clone https://github.com/vinceliuice/Orchis-theme.git

# Install necessary dependencies for building the theme
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc software-properties-common

# Add the Numix PPA and install the Numix Square icon theme
sudo apt-get install -y dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1DCBDC01F9BA0ADA
echo "deb http://ppa.launchpad.net/numix/ppa/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/numix-ppa.list
sudo apt-get update
sudo apt-get install -y numix-icon-theme numix-icon-theme-square

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh --tweaks solid

# Apply the Orchis theme and Numix Square icon theme using sed
xfce_config_file="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"

# Ensure the config file exists before modifying it
if [ -f "$xfce_config_file" ]; then
    # Replace line 5 with the desired GTK theme
    sed -i '5s|.*|    <property name="ThemeName" type="string" value="Orchis-dark"/>|' "$xfce_config_file"
    # Replace line 6 with the desired icon theme
    sed -i '6s|.*|    <property name="IconThemeName" type="string" value="Numix-Square"/>|' "$xfce_config_file"
else
    echo "XFCE config file not found. Please ensure XFCE is installed and configured properly."
fi

echo "Please reboot the system to apply all changes"

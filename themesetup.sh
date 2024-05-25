#!/bin/bash
# Written by Ayaan Eusufzai

# Clone the Orchis theme repository
git clone https://github.com/vinceliuice/Orchis-theme.git

# Install necessary dependencies for building the theme
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh

# Apply the Orchis theme
xfconf-query -c xfwm4 -p /general/theme -s "Orchis-dark"
xfconf-query -c xsettings -p /Net/ThemeName -s "Orchis-dark"

# Install the Numix Square icon theme manually
mkdir -p ~/.icons
cd ~/.icons
wget -O Numix-Square.tar.gz https://github.com/numixproject/numix-icon-theme-square/archive/master.tar.gz
tar -xzvf Numix-Square.tar.gz
mv numix-icon-theme-square-master Numix-Square
rm Numix-Square.tar.gz

# Apply the Numix Square icon theme
xfconf-query -c xsettings -p /Net/IconThemeName -s "Numix-Square"

# Reload the XFCE environment to apply the changes
xfwm4 --replace &
xfce4-panel -r &
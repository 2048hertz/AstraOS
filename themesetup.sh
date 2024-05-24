#!/bin/bash

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

# Install Numix Square icon theme
sudo apt-get install -y numix-icon-theme-square

# Apply the Numix Square icon theme
xfconf-query -c xsettings -p /Net/IconThemeName -s "Numix-Square"

# Reload the XFCE environment to apply the changes
xfwm4 --replace &
xfce4-panel -r &

#!/bin/bash
# Written by Ayaan Eusufzai

# Clone the Orchis theme repository
git clone https://github.com/vinceliuice/Orchis-theme.git

# Install necessary dependencies for building the theme
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh --tweaks solid

# Install the Numix Square icon theme manually
mkdir -p ~/.icons
cd ~/.icons
wget -O Numix-Square.tar.gz https://github.com/numixproject/numix-icon-theme-square/archive/master.tar.gz
tar -xzvf Numix-Square.tar.gz
mv numix-icon-theme-square-master Numix-Square
rm Numix-Square.tar.gz

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

# Reload the XFCE environment to apply the changes
xfwm4 --replace &
xfce4-panel -r &

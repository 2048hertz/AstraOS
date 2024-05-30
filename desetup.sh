#!/bin/bash
# Written by Ayaan Eusufzai

# Theme setup
sudo sh /usr/bin/AstraOS-assets/themesetup.sh

# Define font download URL
font_url="https://github.com/ifvictr/helvetica-neue/archive/refs/heads/master.zip"
temp_dir=$(mktemp -d)

# Top and bottom panel customizations have been removed due to issues with xfce configuration through bash

# THE REBRAND

# Define the new contents
new_contents="Gevox ATD (Astra Technology and Design)\n\nSoftware Team - 2048megahertz@proton.me\n\nBugs should be reported at our github - https://github.com/2048hertz/AstraOS/"

# Write the new contents to the file
echo "$new_contents" | sudo tee /usr/share/xfce4/vendorinfo > /dev/null

echo "Contents of /usr/share/xfce4/vendorinfo have been updated."

# Define the new values
os_name="AstraOS 1.0"
distributor="Gevox Astra Technology and Design"
application_name="about"

# Path to the about dialog configuration file
about_dialog_config="/etc/xdg/xfce4/about-dlg.rc"

# Update the OS name
sed -i "s/^OSName=.*/OSName=\"$os_name\"/" "$about_dialog_config"

# Update the distributor
sed -i "s/^Distributor=.*/Distributor=\"$distributor\"/" "$about_dialog_config"

# Update the application name
sed -i "s/^ApplicationName=.*/ApplicationName=\"$application_name\"/" "$about_dialog_config"

echo "XFCE about dialog configuration updated."

# Define the source and destination paths
SOURCE_DIR="/usr/bin/AstraOS-assets"
DEST_DIR="/usr/share/icons/hicolor"

# Replace the icons for each specified size
sudo cp "$SOURCE_DIR/16x16/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/16x16/apps/org.xfce.panel.applicationsmenu.png"
sudo cp "$SOURCE_DIR/24x24/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/24x24/apps/org.xfce.panel.applicationsmenu.png"
sudo cp "$SOURCE_DIR/32x32/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/32x32/apps/org.xfce.panel.applicationsmenu.png"
sudo cp "$SOURCE_DIR/48x48-resolve/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/48x48/apps/org.xfce.panel.applicationsmenu.png"

echo "Icon replacement completed."

# END OF THE REBRAND

# START OF WALLPAPER CHANGE

xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-1/workspace0/last-image -s /usr/bin/AstraOS-assets/astrawallpaper.png

# Notify XFCE to reload the desktop settings
xfdesktop --reload

echo "Wallpaper changed to $wallpaper_path"

# Use sed to replace the wallpaper setting in the LightDM configuration file
sudo sed -i '9s|.*|#  background = /usr/bin/AstraOS-assets/astralightdm.png/|' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i '10s|.*|#  user-background = false|' /etc/lightdm/lightdm-gtk-greeter.conf

echo "LightDM wallpaper changed to $new_wallpaper."

# END OF WALLPAPER CHANGE

# Function to set XFCE window manager button layout
set_button_layout() {
    xfconf-query -c xfwm4 -p /general/button_layout -s "SH|MC"
    xfconf-query -c xfwm4 -p /general/title_alignment -s "center"
    echo "Button layout changed to SH|MC"
}

# Apply XFCE customizations
# Top and bottom panel customizations have been removed due to issues with xfce configuration through bash
set_button_layout

echo "Default XFCE configuration updated successfully."


# Define the path to the setup script
setup_script="/usr/bin/desetup.sh"

# Define the line to add to adduser.conf
line_to_add="ADDUSER_POST_CREATE_SCRIPT=$setup_script"

# Use sed to insert the line at line number 98 in adduser.conf
sudo sed -i "98i$line_to_add" /etc/adduser.conf

echo "Setup script added to adduser.conf at line 98."

# Clean up temporary directory
rm -rf "$temp_dir"

echo "The XFCE customization script has been executed."

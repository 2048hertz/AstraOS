#!/bin/bash
#Written by Ayaan Eusufzai of Gevox/RTD

# Define font download URL
font_url="https://github.com/ifvictr/helvetica-neue/archive/refs/heads/master.zip"
temp_dir=$(mktemp -d)

# Top and bottom panel customizations have been removed due to issues with xfce configuration through bash

# THE REBRAND

# Define the new contents
new_contents="Gevox RTD (Robert Technology and Design)\n\nSoftware Team - 2048megahertz@proton.me\n\nBugs should be reported at our github - https://github.com/2048hertz/RobertOS/"

# Write the new contents to the file
echo "$new_contents" | sudo tee /usr/share/xfce4/vendorinfo > /dev/null

echo "Contents of /usr/share/xfce4/vendorinfo have been updated."

# Define the new values
os_name="RobertOS 1.0"
distributor="Gevox Robert Technology and Design"
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
SOURCE_DIR="/usr/bin/RobertOS-assets"
DEST_DIR="/usr/share/icons/hicolor"

# Replace the icons for each specified size
sudo cp "$SOURCE_DIR/16x16/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/16x16/apps/org.xfce.panel.applicationsmenu.png"
sudo cp "$SOURCE_DIR/24x24/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/24x24/apps/org.xfce.panel.applicationsmenu.png"
sudo cp "$SOURCE_DIR/32x32/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/32x32/apps/org.xfce.panel.applicationsmenu.png"
sudo cp "$SOURCE_DIR/48x48/org.xfce.panel.applicationsmenu.png" "$DEST_DIR/48x48/apps/org.xfce.panel.applicationsmenu.png"

echo "Icon replacement completed."

# END OF THE REBRAND

# START OF WALLPAPER CHANGE

# Define the path to the wallpaper
wallpaper_path="/usr/bin/RobertOS-assets/robertwallpaper.png"

# Path to the xfce4-desktop.xml file
xfce4_desktop_file="/home/robert/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

# Use sed to update the wallpaper setting in xfce4-desktop.xml
sed -i "s|<property name=\"last-image\" type=\"string\" value=\".*\"/>|<property name=\"last-image\" type=\"string\" value=\"$wallpaper_path\"/>|g" "$xfce4_desktop_file"

# Notify XFCE to reload the desktop settings
xfdesktop --reload
mv /usr/bin/RobertOS-assets/robertwallpaper.png /usr/share/images/desktop-base/default.png

echo "Wallpaper changed to $wallpaper_path"

# Use sed to replace the wallpaper setting in the LightDM configuration file
sudo sed -i '9s|.*|#  background = /usr/bin/RobertOS-assets/robertlightdm.png/|' /etc/lightdm/lightdm-gtk-greeter.conf
sudo sed -i '10s|.*|#  user-background = false|' /etc/lightdm/lightdm-gtk-greeter.conf

echo "LightDM wallpaper changed to $new_wallpaper."

# END OF WALLPAPER CHANGE

# Function to set XFCE window manager button layout
set_button_layout() {
    # Path to the xfce4.xml file
    xfce_config_file="/home/robert/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"

    # Use sed to replace the value of the button_layout property in xfce4.xml
    sed -i '9s|.*|    <property name="button_layout" type="string" value="SH|MC"/>|' "$xfce_config_file"
    sed -i '64s|.*|    <property name="title_alignment" type="string" value="center"/>|' "$xfce_config_file"


    echo "Button layout changed to $button_layout"
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

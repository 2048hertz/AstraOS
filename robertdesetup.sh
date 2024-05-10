#!/bin/bash
#Written by Ayaan Eusufzai of Gevox/RTD

# Define font download URL
font_url="https://github.com/ifvictr/helvetica-neue/archive/refs/heads/master.zip"
temp_dir=$(mktemp -d)

# Top and bottom panel customizations have been removed due to issues with xfce configuration through bash

# THE REBRAND

# Define the new contents
new_contents="Gevox RTD (Robert Technology and Design) Software Team - 2048megahertz@proton.me\nBugs should be reported at our github - https://github.com/2048hertz/RobertOS/"

# Write the new contents to the file
echo -e "$new_contents" | sudo tee /usr/share/xfce4/vendorinfo > /dev/null

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


# END OF THE REBRAND
# START OF WALLPAPER CHANGE

# Define the path to the wallpaper
wallpaper_path="/usr/bin/RobertOS-assets/robertwallpaper.png"

# Path to the xfce4-desktop.xml file
xfce4_desktop_file="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

# Use sed to update the wallpaper setting in xfce4-desktop.xml
sed -i "s|<property name=\"last-image\" type=\"string\" value=\".*\"/>|<property name=\"last-image\" type=\"string\" value=\"$wallpaper_path\"/>|g" "$xfce4_desktop_file"

# Notify XFCE to reload the desktop settings
xfdesktop --reload

echo "Wallpaper changed to $wallpaper_path"

# Define the path to the new wallpaper
new_wallpaper="/usr/bin/RobertOS-assets/robertlightdm.png"

# Define the pattern to search for in the LightDM configuration file
search_pattern="background\s*=\s*.*/.*"

# Define the replacement string
replacement="background = $new_wallpaper"

# Use sed to replace the wallpaper setting in the LightDM configuration file
sudo sed -i "s|$search_pattern|$replacement|" /etc/lightdm/lightdm-gtk-greeter.conf

echo "LightDM wallpaper changed to $new_wallpaper."

# END OF WALLPAPER CHANGE

# Function to set XFCE window manager button layout
set_button_layout() {
    # Define the desired button layout
    button_layout="SH|MC"

    # Path to the xfce4.xml file
    xfce_config_file="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"

    # Use sed to replace the value of the button_layout property in xfce4.xml
    sed -i "s|<property name=\"button_layout\" type=\"string\" value=\".*\"/>|<property name=\"button_layout\" type=\"string\" value=\"$button_layout\"/>|g" "$xfce_config_file"

    echo "Button layout changed to $button_layout"
}

# Function to change system fonts to Helvetica Neue Medium if available
change_system_fonts() {
    # Path to x-settings.xml file
    x_settings_file="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/x-settings.xml"

    # Path to the Helvetica font directory
    font_directory="/usr/bin/RobertOS-assets/fonts"

    # Check if Helvetica Neue Medium font is available
    if fc-list | grep -i "Helvetica Neue Medium" >/dev/null; then
        # Set system font to Helvetica Neue Medium
        sed -i 's|<property name="FontName" type="string" value=".*"/>|<property name="FontName" type="string" value="Helvetica Neue Medium"/>|g' "$x_settings_file"
        echo "System fonts changed to Helvetica Neue Medium"
    else
        # Check if the font directory exists
        if [ -d "$font_directory" ]; then
            # Copy Helvetica Neue Medium font file to ~/.local/share/fonts directory
            cp "$font_directory/HelveticaNeue-Medium.otf" ~/.local/share/fonts/
            # Update font cache
            fc-cache -f -v
            echo "Helvetica Neue Medium font installed successfully."

            # Set system font to Helvetica Neue Medium
            sed -i 's|<property name="FontName" type="string" value=".*"/>|<property name="FontName" type="string" value="Helvetica Neue Medium"/>|g' "$x_settings_file"
            echo "System fonts changed to Helvetica Neue Medium"
        else
            echo "Helvetica Neue Medium font directory not found: $font_directory"
        fi
    fi
}

# Apply XFCE customizations
# Top and bottom panel customizations have been removed due to issues with xfce configuration through bash
set_button_layout
change_system_fonts

echo "Default XFCE configuration updated successfully."


# Define the path to the setup script
setup_script="/usr/bin/robertdesetup.sh"

# Define the line to add to adduser.conf
line_to_add="ADDUSER_POST_CREATE_SCRIPT=$setup_script"

# Use sed to insert the line at line number 98 in adduser.conf
sudo sed -i "98i$line_to_add" /etc/adduser.conf

echo "Setup script added to adduser.conf at line 98."

# Clean up temporary directory
rm -rf "$temp_dir"

echo "The XFCE customization script has been executed."
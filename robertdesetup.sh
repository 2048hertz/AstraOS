#!/bin/bash

# Define font download URL
font_url="https://github.com/ifvictr/helvetica-neue/archive/refs/heads/master.zip"
temp_dir=$(mktemp -d)

# Function to apply XFCE panel customizations for the top panel
apply_top_panel_customizations() {
    # Set icon properties for the applications menu
    sed -i 's|<property name="menu-icon" type="string" value=".*"/>|<property name="menu-icon" type="string" value="/usr/bin/RobertOS-assets/logo.png"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    sed -i 's|<property name="button-icon" type="string" value=".*"/>|<property name="button-icon" type="string" value="/usr/bin/RobertOS-assets/logo.png"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

    # Remove the title from the applications menu
    sed -i 's|<property name="show-button-label" type="bool" value="true"/>|<property name="show-button-label" type="bool" value="false"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

    # Change the title of the session menu
    sed -i 's|<property name="title" type="string" value=".*"/>|<property name="title" type="string" value=" Session Menu "/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
}

# Function to apply XFCE panel customizations for the bottom panel
apply_bottom_panel_customizations() {
    # Set icon properties for the bottom panel
    sed -i 's|<property name="menu-icon" type="string" value=".*"/>|<property name="menu-icon" type="string" value="/usr/bin/RobertOS-assets/logofull.png"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    sed -i 's|<property name="icon-size" type="int" value=".*"/>|<property name="icon-size" type="int" value="0"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    sed -i 's|<property name="show-button-label" type="bool" value="true"/>|<property name="show-button-label" type="bool" value="false"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    sed -i 's|<property name="position" type="string" value=".*"/>|<property name="position" type="string" value="p=6;x=0;y=0"/>|' ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
}


# Define the path to the wallpaper
wallpaper_path="/usr/bin/RobertOS-assets/robertwallpaper.png"

# Path to the xfce4-desktop.xml file
xfce4_desktop_file="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

# Use sed to update the wallpaper setting in xfce4-desktop.xml
sed -i "s|<property name=\"last-image\" type=\"string\" value=\".*\"/>|<property name=\"last-image\" type=\"string\" value=\"$wallpaper_path\"/>|g" "$xfce4_desktop_file"

# Notify XFCE to reload the desktop settings
xfdesktop --reload

echo "Wallpaper changed to $wallpaper_path"

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
apply_top_panel_customizations
apply_bottom_panel_customizations
set_button_layout
change_system_fonts

echo "Default XFCE configuration updated successfully."

# Copy the script to the default skeleton directory
sudo cp "$0" /etc/skel/xfce_customization.sh
sudo chmod +x /etc/skel/xfce_customization.sh

# Clean up temporary directory
rm -rf "$temp_dir"

echo "The XFCE customization script has been executed."



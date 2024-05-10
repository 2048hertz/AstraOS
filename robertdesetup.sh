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

# Function to set XFCE window manager button layout
set_button_layout() {
    # Define the desired button layout
    button_layout="ROLHCT"

    # Set the button layout using xfconf-query
    xfconf-query -c xfwm4 -p /general/button_layout -s "$button_layout"

    echo "Button layout changed to $button_layout"
}

# Function to change system fonts to Helvetica if available
change_system_fonts() {
    # Check if Helvetica font is available
    if fc-list | grep -i "helvetica" >/dev/null; then
        # Set system font to Helvetica
        xfconf-query -c xsettings -p /Net/ThemeName -s "Helvetica"
        xfconf-query -c xsettings -p /Gtk/FontName -s "Helvetica"
        echo "System fonts changed to Helvetica"
    else
        # Install Helvetica font
        echo "Helvetica font not found. Downloading and installing..."
        # Download Helvetica font
        wget -q --show-progress -O "$temp_dir/helvetica-neue.zip" "$font_url"
        # Extract the font files
        unzip -qq "$temp_dir/helvetica-neue.zip" -d "$temp_dir"
        # Move font files to ~/.local/share/fonts directory
        mkdir -p ~/.local/share/fonts
        cp -r "$temp_dir/helvetica-neue-master"/*.otf ~/.local/share/fonts/
        # Update font cache
        fc-cache -f -v
        echo "Helvetica font installed successfully."
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



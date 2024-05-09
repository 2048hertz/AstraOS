#!/bin/bash

# Define icon paths
icon_path_top="/usr/bin/RobertOS-assets/logo.png"
icon_path_bottom="/usr/bin/RobertOS-assets/logofull.png"

# Function to apply XFCE panel customizations
apply_panel_customizations() {
    # Set icon properties for the top panel
    xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -t int -a -s 1
    xfconf-query -c xfce4-panel -p /panels/panel-1/length -t int -s 100
    xfconf-query -c xfce4-panel -p /panels/panel-1/position -t string -s "p=6;x=0;y=0"
    xfconf-query -c xfce4-panel -p /panels/panel-1/position-locked -t bool -s true
    xfconf-query -c xfce4-panel -p /panels/panel-1/background-type -t int -s 0
    xfconf-query -c xfce4-panel -p /panels/panel-1/background-style -t int -s 0
    xfconf-query -c xfce4-panel -p /panels/panel-1/icon-size -t int -s 0
    xfconf-query -c xfce4-panel -p /panels/panel-1/row-size -t int -s 0
    xfconf-query -c xfce4-panel -p /panels/panel-1/length-adjust -t bool -s false
    xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -t int -s 0
    xfconf-query -c xfce4-panel -p /panels/panel-1/enter-opacity -t int -s 100
    xfconf-query -c xfce4-panel -p /panels/panel-1/leave-opacity -t int -s 100
    xfconf-query -c xfce4-panel -p /panels/panel-1/opacity -t int -s 100
    xfconf-query -c xfce4-panel -p /panels/panel-1/dark-mode -t bool -s false

    # Restart the panel to apply changes
    xfce4-panel -r
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
        echo "Helvetica font not found. Using default system fonts."
    fi
}

# Function to apply all XFCE customizations
apply_xfce_customizations() {
    # Apply panel customizations
    apply_panel_customizations

    # Set XFCE window manager button layout
    set_button_layout

    # Change system fonts to Helvetica if available
    change_system_fonts

    echo "Default XFCE configuration updated successfully."
}

# Execute all XFCE customizations
apply_xfce_customizations

echo "The XFCE customization script has been executed."

# Copy the script to the default skeleton directory
sudo cp "$0" /etc/skel/xfce_customization.sh
sudo chmod +x /etc/skel/xfce_customization.sh

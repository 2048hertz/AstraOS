#!/bin/bash
sudo su
# Define icon paths
icon_path_top="/usr/bin/RobertOS-assets/logo.png"
icon_path_bottom="/usr/bin/RobertOS-assets/logofull.png"

# Function to apply XFCE panel customizations
apply_panel_customizations() {
    # Set icon properties for the top panel
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/menu-icon -t string -s "$icon_path_top"
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/button-icon -t string -s "$icon_path_top"
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/icon-size -t int -s 0
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/show-button-label -t bool -s false

    # Restart the panel to apply changes
    xfce4-panel -r

    # Set properties for the bottom panel
    xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -t int -a -s 1
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/menu-icon -t string -s "$icon_path_bottom"
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/icon-size -t int -s 0
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/show-button-label -t bool -s false

    # Move the application menu to the left
    xfconf-query -c xfce4-panel -p /plugins/plugin-1/position -t int -s 0

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

# Function to apply all XFCE customizations
apply_xfce_customizations() {
    # Apply panel customizations
    apply_panel_customizations

    # Set XFCE window manager button layout
    set_button_layout

    echo "Default XFCE configuration updated successfully."
}

# Execute all XFCE customizations
apply_xfce_customizations

echo "The XFCE customization script has been executed."

# Copy the script to the default skeleton directory
sudo cp "$0" /etc/skel/xfce_customization.sh
sudo chmod +x /etc/skel/xfce_customization.sh

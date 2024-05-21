#!/bin/bash
# Welcome to the Robert Computer Operating System build script 2
# Written by Ayaan Eusufzai
# Version Teddy-Bear LTS V1
wget https://github.com/2048hertz/roscamera/archive/refs/heads/main.zip
sudo unzip main.zip
sudo rm main.zip
cd /roscamera-main/
sudo sh installer.sh
cd
sudo sh /usr/bin/RobertOS-assets/desetup.sh
sudo apt-get remove -y rp-prefapps lxappearance lxde lxde-* lxinput lxmenu-data lxpanel lxpolkit lxrandr lxsession* lxsession lxshortcut lxtask lxterminal
sudo apt-get autoremove -y && sudo apt-get autoclean -y
sudo wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash
sudo wget https://github.com/2048hertz/robertosupdatemanager/releases/download/1.0/rum.sh
sudo sh rum.sh


# MAIN CONFIG FINISHED


# Define the path to the script to be executed
script_path="/usr/bin/RobertOS-assets/installer_script.sh"
script_path2="/usr/bin/RobertOS-assets/user_interaction.sh"

# Make the scripts executable
chmod +x "$script_path"
chmod +x "$script_path2"

# Create a new service unit file for the installer
installer_service_path="/etc/systemd/system/installer.service"

# Write installer service content to the file (corrected version)
sudo tee "$installer_service_path" > /dev/null <<EOL
[Unit]
Description=installer-activation
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/RobertOS-assets/installer_script.sh
StandardInput=tty-force

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable the installer service (corrected: no need for --now)
sudo systemctl enable installer.service
sudo systemctl start installer.service

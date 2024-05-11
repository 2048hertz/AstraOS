#!/bin/bash
# Welcome to the Robert Computer Operating System build script 2
# Written by Ayaan Eusufzai
# Version Teddy-Bear LTS V1
sudo cp -r /home/RobertOS-assets /usr/bin/RobertOS-assets
sudo rm -r /home/RobertOS-assets
wget https://github.com/2048hertz/roscamera/archive/refs/heads/main.zip
sudo unzip main.zip
sudo rm main.zip
cd /roscamera-main/
sudo sh installer.sh
cd
sudo sh /usr/bin/RobertOS-assets/robertdesetup.sh
sudo apt-get remove -y rp-prefapps lxappearance lxde lxde-* lxinput lxmenu-data lxpanel lxpolkit lxrandr lxsession* lxsession lxshortcut lxtask lxterminal
sudo apt-get autoremove -y && sudo apt-get autoclean -y
sudo wget https://github.com/2048hertz/robertosupdatemanager/releases/download/1.0/rum.sh
sudo sh rum.sh


# MAIN CONFIG FINISHED


# Define the path to the script to be executed
script_path="/usr/bin/RobertOS-assets/installer_script.sh"

# Make the script executable
chmod +x "$script_path"

# Create a new service unit file for phase2
installer_service_path="/etc/systemd/system/installer.service"

# Write installer service content to the file (corrected version)
sudo tee "$installer_service_path" > /dev/null <<EOL
[Unit]
Description=installer-activation
After=network.target

[Service]
Type=oneshot
ExecStart=/bin/bash -c "/usr/bin/RobertOS-assets/installer_script.sh"

[Install]
WantedBy=default.target
EOL

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable the phase2 service (corrected: no need for --now)
sudo systemctl enable installer.service
sudo systemctl start installer.service

echo "RobertOS installer service enabled. It will run the script $script_path continuously after booting and restart on failure."
sudo systemctl disable phase2.service
sudo reboot
#!/bin/bash
# Welcome to the Robert Computer Operating System build script 2
# Written by Ayaan Eusufzai
# Version Teddy-Bear LTS V1
sudo mv /home/RobertOS-assets /usr/bin/RobertOS-assets
sudo sh /usr/bin/RobertOS-assets/robertdesetup.sh
sudo apt-get remove -y rp-prefapps lxappearance lxde lxde-* lxinput lxmenu-data lxpanel lxpolkit lxrandr lxsession* lxsession lxshortcut lxtask lxterminal
sudo apt-get autoremove -y && sudo apt-get autoclean -y
sudo wget https://github.com/2048hertz/robertosupdatemanager/releases/download/1.0/rum.zip
sudo unzip rum.zip
cd /rum/
sudo sh rum.sh
cd


# MAIN CONFIG FINISHED


# Define the path to your Python installer script
script_path="/usr/bin/RobertOS-assets/installer_script.py"

# Define the directory containing your script
script_directory="/usr/bin/RobertOS-assets/"

# Create the systemd service unit file
cat <<EOF | sudo tee /etc/systemd/system/robertos_installer.service > /dev/null
[Unit]
Description=RobertOS Installer Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 $script_path
WorkingDirectory=$script_directory
StandardOutput=journal
StandardError=journal
SyslogIdentifier=robertos_installer

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable robertos_installer.service

# Start the service
sudo systemctl start robertos_installer.service

echo "RobertOS Installer service has been configured to run at boot."

sudo reboot

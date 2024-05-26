#!/bin/bash
# Written by Ayaan Eusufzai
# Made to recompile Xfce4 components with our oaknut versions.

# Variables
REPO_URL="https://github.com/2048hertz/oaknut-xfce/archive/refs/heads/xfce-4.18.zip"
ZIP_FILE="xfce-4.18.zip"
DIR_NAME="./oaknut-xfce-xfce-4.18"

# Ensure dependencies are installed (adjust as necessary for your system)
sudo apt-get update
sudo apt-get install -y build-essential autoconf automake libtool pkg-config libxfce4ui-2-dev libxfce4util-dev libgtk-3-dev libglib2.0-dev libdbus-glib-1-dev intltool wget unzip xfce4-dev-tools

# Download the repository zip file
wget $REPO_URL -O $ZIP_FILE

# Unzip the file
unzip $ZIP_FILE

# Navigate to the project directory
cd $DIR_NAME

# Prepare the build system
./autogen.sh

# Build the project
make

# Install the project
sudo make install

# Print completion message
echo "Custom xfce4-panel built and installed successfully."

# Instructions to restart the panel (optional, requires user confirmation)
read -p "Would you like to restart the xfce4-panel now? (y/N): " restart_choice
if [[ $restart_choice =~ ^[Yy]$ ]]; then
    xfce4-panel -r
    echo "xfce4-panel restarted."
else
    echo "You can restart the xfce4-panel manually by running 'xfce4-panel -r'."
fi

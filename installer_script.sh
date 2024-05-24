#!/bin/bash
# Written by Ayaan Eusufzai

# Prompt user for inputs
username=$(systemd-ask-password "Enter Username: ")
password=$(systemd-ask-password "Enter Password: ")
full_name=$(systemd-ask-password "Enter Full Name: ")

# Run the user interaction script and capture timezone and language selections
read timezone language < <(/usr/bin/RobertOS-assets/user_interaction.sh)

# Perform installation
useradd -m "$username"
echo -e "$password\n$password" | passwd "$username"

# Set locale
localectl set-locale "LANG=$language"

# Set timezone
timedatectl set-timezone "$timezone"

# Disable the service after user creation
systemctl disable installer.service

echo "Installation process completed."
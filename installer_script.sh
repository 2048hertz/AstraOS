#!/bin/bash

# Prompt user for inputs
read -p "Enter Username: " username
read -p "Enter Password: " -s password
echo ""
read -p "Enter Full Name: " full_name

# Select language
echo "Select Language:"
select locale in "en_US.UTF-8" "fr_FR.UTF-8" "de_DE.UTF-8" "bn_BD.UTF-8"; do
    break
done

# Select timezone
echo "Select Timezone:"
select timezone in $(timedatectl list-timezones); do
    break
done

# Perform installation
useradd -m $username
echo -e "$password\n$password" | passwd $username

# Set locale
sudo localectl set-locale "LANG=$locale"

# Set timezone
sudo timedatectl set-timezone $timezone

# Disable the service after user creation
sudo systemctl disable installer_script.service

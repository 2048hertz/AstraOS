#!/bin/bash
# Written by Ayaan Eusufzai

# Prompt user to select timezone
timezone=$(whiptail --title "Timezone Selection" --menu "Choose your timezone:" 20 60 15 $(timedatectl list-timezones) 3>&1 1>&2 2>&3)
exit_status=$?
if [ $exit_status -ne 0 ]; then
    echo "Timezone selection cancelled."
    exit 1
fi

# Prompt user to select language
language=$(whiptail --title "Language Selection" --menu "Choose your language:" 20 60 15 \
"en_US.UTF-8" "English" \
"fr_FR.UTF-8" "French" \
"de_DE.UTF-8" "German" \
"bn_BD.UTF-8" "Bengali" \
3>&1 1>&2 2>&3)
exit_status=$?
if [ $exit_status -ne 0 ]; then
    echo "Language selection cancelled."
    exit 1
fi

# Output selections
echo "$timezone"
echo "$language"

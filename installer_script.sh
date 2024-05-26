#!/bin/bash

# Install Zenity if not already installed
if ! command -v zenity &> /dev/null
then
  apt-get update
  apt-get install -y zenity
fi

# Function to prompt for input with a Zenity UI
prompt() {
  local prompt_text=$1
  local default_value=$2
  local user_input

  user_input=$(zenity --entry --title="Setup" --text="$prompt_text" --entry-text="$default_value")
  echo "${user_input:-$default_value}"
}

# Delete all users except root
existing_users=$(getent passwd {1000..60000} | cut -d: -f1)
for user in $existing_users; do
  deluser --remove-home $user
done

# Setup user
while true; do
  new_user=$(prompt "Enter new username" "pi")
  if id "$new_user" &>/dev/null; then
    zenity --error --text="User $new_user already exists. Please try again."
  else
    adduser --gecos "" $new_user
    usermod -aG sudo $new_user
    break
  fi
done

# List all timezones and prompt user to select one
timezones=$(timedatectl list-timezones)
selected_timezone=$(echo "$timezones" | zenity --list --title="Select Timezone" --column="Timezones" --width=400 --height=600)

if [ -z "$selected_timezone" ]; then
  zenity --error --text="No timezone selected. Defaulting to UTC."
  selected_timezone="UTC"
fi

timedatectl set-timezone $selected_timezone

# Cleanup to prevent this script from running on every boot
rm -f /usr/local/bin/installer.sh
sed -i '/\/usr\/local\/bin\/installer.sh/d' /etc/rc.local

zenity --info --text="Setup complete. Please reboot your system."

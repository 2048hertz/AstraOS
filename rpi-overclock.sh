#!/bin/bash
# Written by Ayaan Eusufzai

# Backup the existing config file
sudo cp /boot/firmware/config.txt /boot/firmware/config.txt.backup

# Overclock the Raspberry Pi
echo 'Overclocking the Raspberry Pi...'
sudo bash -c "echo '

# Overclock settings
force_turbo=1
arm_freq=3000
gpu_freq=1000

' >> /boot/firmware/config.txt"

echo 'Overclocking done.'

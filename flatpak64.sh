# #!/bin/bash
# Written by Ayaan Eusufzai
# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Install Box64 (add your specific method if not using apt)
apt update && apt install -y box64

# Add Flathub repository if it doesn't already exist
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Enable x86_64 architecture in Flatpak
flatpak --user --arch=x86_64

# Modify the Flathub configuration to support x86_64 architecture
FLATPAK_REPO_FILE="/etc/flatpak/remotes.d/flathub.flatpakrepo"
mkdir -p /etc/flatpak/remotes.d

if [ ! -f "$FLATPAK_REPO_FILE" ]; then
    cat <<EOL > "$FLATPAK_REPO_FILE"
[Remote]
Name=flathub
Url=https://flathub.org/repo/
SupportedArchitectures=arm64;x86_64
EOL
else
    if ! grep -q "SupportedArchitectures" "$FLATPAK_REPO_FILE"; then
        echo "SupportedArchitectures=arm64;x86_64" >> "$FLATPAK_REPO_FILE"
    else
        sed -i 's/SupportedArchitectures=.*/SupportedArchitectures=arm64;x86_64/' "$FLATPAK_REPO_FILE"
    fi
fi

# Update Flatpak to recognize the new architecture
flatpak update --arch=x86_64

echo "Configuration complete. You can now install x86_64 applications via Flatpak."

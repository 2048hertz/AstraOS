#!/bin/bash
# Written by Ayaan Eusufzai

# Clone the Orchis theme repository
git clone https://github.com/vinceliuice/Orchis-theme.git

# Install necessary dependencies for building the theme
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc software-properties-common

# Add the Numix PPA and install the Numix Square icon theme
sudo apt-get install -y dirmngr
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1DCBDC01F9BA0ADA || true
echo "deb http://ppa.launchpad.net/numix/ppa/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/numix-ppa.list
sudo apt-get update -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true
sudo apt-get install -y numix-icon-theme numix-icon-theme-square

# Navigate to the cloned directory
cd Orchis-theme

# Run the installation script
./install.sh --tweaks solid

# Define the new content for xsettings.xml
new_xsettings_content='<?xml version="1.0" encoding="UTF-8"?>
<channel name="xsettings" version="1.0">
  <property name="Net" type="empty">
    <property name="ThemeName" type="string" value="Orchis-dark"/>
    <property name="IconThemeName" type="string" value="Numix-Square"/>
    <property name="DoubleClickTime" type="empty"/>
    <property name="DoubleClickDistance" type="empty"/>
    <property name="DndDragThreshold" type="empty"/>
    <property name="CursorBlink" type="empty"/>
    <property name="CursorBlinkTime" type="empty"/>
    <property name="SoundThemeName" type="empty"/>
    <property name="EnableEventSounds" type="empty"/>
    <property name="EnableInputFeedbackSounds" type="empty"/>
  </property>
  <property name="Xft" type="empty">
    <property name="DPI" type="empty"/>
    <property name="Antialias" type="empty"/>
    <property name="Hinting" type="empty"/>
    <property name="HintStyle" type="empty"/>
    <property name="RGBA" type="empty"/>
  </property>
  <property name="Gtk" type="empty">
    <property name="CanChangeAccels" type="empty"/>
    <property name="ColorPalette" type="empty"/>
    <property name="FontName" type="empty"/>
    <property name="MonospaceFontName" type="empty"/>
    <property name="IconSizes" type="empty"/>
    <property name="KeyThemeName" type="empty"/>
    <property name="ToolbarStyle" type="empty"/>
    <property name="ToolbarIconSize" type="empty"/>
    <property name="MenuImages" type="empty"/>
    <property name="ButtonImages" type="empty"/>
    <property name="MenuBarAccel" type="empty"/>
    <property name="CursorThemeName" type="empty"/>
    <property name="CursorThemeSize" type="empty"/>
    <property name="DecorationLayout" type="empty"/>
    <property name="DialogsUseHeader" type="empty"/>
    <property name="TitlebarMiddleClick" type="empty"/>
  </property>
  <property name="Gdk" type="empty">
    <property name="WindowScalingFactor" type="empty"/>
  </property>
</channel>'

# Write the new content to xsettings.xml
xfce_config_file="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"
echo "$new_xsettings_content" > "$xfce_config_file"

echo "Please reboot the system to apply all changes"

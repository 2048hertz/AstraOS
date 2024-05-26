#!/bin/bash
# Welcome to the Robert Computer Operating System build script 2
# Written by Ayaan Eusufzai
# Version Teddy-Bear V1

# Add camera installation code here

sudo sh /usr/bin/RobertOS-assets/desetup.sh
sudo apt-get remove -y rp-prefapps lxappearance lxde lxde-* lxinput lxmenu-data lxpanel lxpolkit lxrandr lxsession* lxsession lxshortcut lxtask lxterminal
sudo apt-get autoremove -y && sudo apt-get autoclean -y
sudo wget https://github.com/2048hertz/robertosupdatemanager/releases/download/1.0/rum.sh
sudo sh rum.sh


# MAIN CONFIG FINISHED

# Finishing up
sudo sh /usr/bin/RobertOS-assets/prepare_image.sh

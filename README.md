# RobertOS HOME
An ARM64 Linux based operating system for the Robert Computer (Raspberry Pi handheld computer). Based off of Raspberry Pi OS

WORK IN PROGRESS - Currently RobertOS can only be built by the user

RobertOS is easy to build compared to other operating systems.
The asset branch contains bash and python scripts to build the OS.
There is a version up right now but it's not stable and well-tested. It will require some more work.

HOW TO BUILD

1) Install the "2024-03-15-raspios-bookworm-armhf.img.xz" version of Raspberry Pi OS
2) Do a basic set up, do not update or install anything.
3) Run in the terminal - wget https://github.com/2048hertz/RobertOS/releases/download/0.1/installer.sh
4) Configuration will be done for you!
5) You will boot into an installer where you will set up your user account, set your timezone, locale, etc.
6) There! In 5 steps you have successfully built RobertOS

OPTIONAL

The top and bottom panel are not automatically configured due to limitations with xfconf-query
Thus, you may change the configurations how they are dreamed to be by yourself.
Right click the application menu and click properties
Change the icon to logo.png in /usr/bin/RobertOS-assets/
Change the session menu from the username to a custom value which is exactly " Session Menu " with the spaces
Remove all seperators and add the reboot, hibernate, etc options
For the bottom panel, remove the seperator beside the show desktop plugin then add an application menu plugin and configure it like the top panel application menu but this time use the image file logofull.png instead of logo.png

CONGRATULATIONS, YOU HAVE BUILT ROBERTOS!


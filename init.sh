#!/bin/bash
echo "====Bendcontrol initialization script===="
echo "====Updating pacman===="
sudo pacman -Syu --noconfirm
echo "====Installing Java===="
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.7-tem
echo "====Installing Git===="
sudo pacman -S git --noconfirm
git config --global credential.helper store
echo "====Downloading project files===="
echo "Enter your github username and (as a password) personal access token"
git clone https://github.com/langmuirsystems/bendcontrol.git
cd bendcontrol
git fetch
git pull origin debug/pi
git checkout origin/debug/pi
echo "====Building project for faster startup"
exec gradlew build
echo "====adding user to UUCP group to allow usb device connections===="
sudo gpasswd -a $USER uucp
echo "====Removing Desktop Environment"
sudo pacman -Rcs xfce4 --noconfirm
sudo pacman -Rcs xfce4-goodies --noconfirm
sudo pacman -Rcs lightdm --noconfirm
echo "====Installing XINIT====="
sudo pacman -S xorg-xinit --noconfirm
echo "====Writing .xinitrc====="
echo "cd bendcontrol; bash gradlew run"
echo "====Restarting===="
sudo reboot

#!/bin/bash

# check if AUR helper is installed

if type -p yay > /dev/null; then
    aur_helper=yay

elif type -p paru > /dev/null; then
    aur_helper=paru
else
    read -n 1 -p "AUR helper not installed, install? (Y/n): " answer
    answer="${answer:=Y}"

    if [ $answer == "Y" ] || [ $answer == "y" ]; then
	bash installaur.sh
    else
	echo -e "\nInstall stopped"
	exit 1
    fi
fi

if [ $aur_helper ]; then
    $aur_helper -S --needed $(awk '{print $1}'  packages.lst)
fi

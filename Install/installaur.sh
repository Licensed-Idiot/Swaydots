#!/bin/bash

# get the prefferred AUR helper
echo -e "\n" 
read -n 1 -p "Install AUR helper
	[1] yay
	[2] paru 
	(default=1): " aur
echo -e "\n"

# set default option for AUR helper
if ! [ $aur ]; then
    aur="1"
fi

# if yay, install yay
if [ $aur == "1" ]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

# if paru install paru
elif [ $aur == "2" ]; then
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si

else
    echo -e "Not a valid option"
fi

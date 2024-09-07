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
    cd ~/Swaydots/Install && rm -rf yay
    export AUR_HELPER=yay

# if paru install paru
elif [ $aur == "2" ]; then
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ~/Swaydots/Install && rm -rf paru
    export AUR_HELPER=paru

else
    echo -e "Not a valid option"
fi

bash install.sh

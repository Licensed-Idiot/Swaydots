#!/bin/bash

# check if AUR helper is installed

if pacman -Qi yay > /dev/null; then
    export AUR_HELPER=yay

elif pacman -Qi paru > /dev/null; then
    export AUR_HELPER=paru
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

if [ $AUR_HELPER ]; then
    $AUR_HELPER -S --needed --noconfirm $(awk '{print $1}'  packages.lst)
fi


# if zsh installed, install Oh-My-Zsh
if pacman -Qi zsh > /dev/null && pacman -Qi oh-my-zsh-git > /dev/null; then
    # make zsh default shell
    chsh -s $(which zsh)

    # export ZSH_CUSTOM for the plugins
    export ZSH_CUSTOM="/usr/share/oh-my-zsh/custom"

    # install zsh plugins
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # install p10k
    sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# check if the configs files are present, copy the config files
if [ -d "$HOME/Swaydots/Configs" ]; then
    cp -r $HOME/Swaydots/Configs/. $HOME/
else
    echo -e "Could not find path to configs, make sure they are located in ~/Swaydots/Configs"
    exit 2
fi

# install GTK theme
if [ -d "$HOME/Swaydots/Temp" ]; then
    git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git $HOME/Swaydots/Temp/Gruvbox-GTK-Theme
    cd ~/Swaydots/Temp/Gruvbox-GTK-Theme/themes
    ./install.sh -t red -c dark
    cd ~/Swaydots/Install && rm -rf ~/Swaydots/Temp
else
    mkdir -p $HOME/Swaydots/Temp
    git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git $HOME/Swaydots/Temp/Gruvbox-GTK-Theme
    cd ~/Swaydots/Temp/Gruvbox-GTK-Theme/themes
    ./install.sh -t red -c dark
    cd ~/Swaydots/Install && rm -rf ~/Swaydots/Temp
fi

# reboot the system
read -n 1 -p "Reboot now? (Y/n): " reboot
reboot="${reboot:=Y}"

if [ $reboot == "Y" ] || [ $reboot == "y" ]; then
    reboot
else
    echo "Reboot canceled, the dotfiles will not take effect unless you reboot"
fi

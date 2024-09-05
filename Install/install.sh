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


# if zsh installed, install Oh-My-Zsh
if type -p zsh > /dev/null; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # install p10k
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

    # install zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# check if the configs files are present, copy the config files
if [ -d "$HOME/dotfiles/Configs" ]; then
    cp -r $HOME/dotfiles/Configs/. $HOME/
else
    echo -e "Could not find path to configs, make sure they are located in ~/dotfiles/Configs"
fi

# reboot the system
read -n 1 -p "Reboot now? (Y/n): " reboot

if [ $reboot == "Y" ] || [ $reboot == "y" ]; then
    reboot
else
    echo "Reboot canceled, the dotfiles will not take effect unless you reboot"
fi

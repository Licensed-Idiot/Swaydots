#!/bin/bash

command="
fastfetch
yay -Syu
read -n 1 -p 'Press any key to continue...'
"
sh -c "${command}"

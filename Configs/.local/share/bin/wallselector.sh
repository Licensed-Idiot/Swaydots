#!/usr/bin/env bash
#  ██╗    ██╗ █████╗ ██╗     ██╗     ██████╗  █████╗ ██████╗ ███████╗██████╗
#  ██║    ██║██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
#  ██║ █╗ ██║███████║██║     ██║     ██████╔╝███████║██████╔╝█████╗  ██████╔╝
#  ██║███╗██║██╔══██║██║     ██║     ██╔═══╝ ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
#  ╚███╔███╔╝██║  ██║███████╗███████╗██║     ██║  ██║██║     ███████╗██║  ██║
#   ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
#
#  ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗
#  ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  ██████╔╝
#  ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██╔══╝  ██╔══██╗
#  ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗██║  ██║
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
#	originally written by: gh0stzk - https://github.com/gh0stzk/dotfiles
#	rewritten for swww by :	 Licensed-Idiot - hlink to dotfiles in future
#	Info    - This script runs the rofi launcher, to select
#             the wallpapers included in the theme you are in.


# Verifies if xdpyinfo and imagemagick are installed
for app in xorg-xdpyinfo imagemagick; do
    if ! pacman -Qq $app > /dev/null 2>&1; then
        dunstify "Missing package" "Please install the $app package to continue" -u critical
        exit 1
    fi
done

# Set some variables
wall_dir="$HOME/.config/wallpapers"
cacheDir="$HOME/.cache/$USER/gruvbox"
rofi_command="rofi -dmenu -theme $HOME/.config/rofi/WallSelect.rasi -theme-str $rofi_override"

monitor_res=$(($(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1) * 17 / $(xdpyinfo | awk '/resolution/{print $2}' | cut -d 'x' -f1)))
rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    [ -f "$imagen" ] || continue
    nombre_archivo=$(basename "$imagen")
    [ -f "${cacheDir}/${nombre_archivo}" ] || magick "$imagen" -resize 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
done

# Launch rofi
wall_selection=$(find "${wall_dir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

swww_command=" swww img \
	--transition-type=grow \
	--transition-pos=top-right \
	--transition-fps=24
"

# Set wallpaper
[[ -n "$wall_selection" ]] && $swww_command "${wall_dir}/${wall_selection}"

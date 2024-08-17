#!/bin/bash






# if you want a blurred backround edit ~/.config/wlogout/style.css
# and change backround-color: rgba(40,40,40, 0.8); under window 
# with backround-image: url("/tmp/shot_blurred.png");
# and uncommet the lines below
#
# grim /tmp/shot.png
# magick /tmp/shot.png -blur 0x5 /tmp/shot_blurred.png

wlogout -b 2 -c 0 -r 0 -m 0 -p layer-shell


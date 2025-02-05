#!/bin/bash

# Wait for BSPWM to initialize completely
sleep 2

# Open Brave in the 1st workspace
brave &
sleep 1  
bspc node -d 1

# Open Terminal with Tmux in the 2nd workspace
kitty -e tmux -u &
sleep 1  
bspc node -d 2

# Open Whatsapp in the 6th workspace
gtk-launch brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop &
sleep 1
bspc node -d 6

# Return focus to the first workspace
bspc desktop -f 1


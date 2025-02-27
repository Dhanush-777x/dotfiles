#!/bin/bash

# Show notification using dunstify
dunstify "Welcome Back Dhanush!" "Setting Up Your Workspace. Please Wait..." -t 5000 &

# Wait for BSPWM to initialize completely
sleep 2

# Open Whatsapp in the 6th workspace
gtk-launch brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop &
sleep 1
bspc node -d 6
sleep 1

# Start two tmux sessions
tmux -u new-session -d -s Term        # Create Term session
tmux -u new-session -d -s nvim        # Create nvim session

# Open nvim inside the "nvim" session
tmux -u send-keys -t nvim "nvim" Enter
tmux -u detach -s nvim 

# Open terminal in workspace 2 with the "Term" session
kitty --class "Term" -e tmux -u attach-session -t Term &
sleep 1  # Wait for the terminal to launch

# Move it to workspace 3
bspc node -d 3
sleep 1  

# Open Work Brave in the 2nd workspace
brave &
sleep 1  
bspc node -d 2
sleep 1

# Open Personal Brave in the 1st workspace
brave &
sleep 1  
bspc node -d 1


# Return focus to the first workspace
bspc desktop -f 2

#Ready to go notification
dunstify "Setting Up Done" "You are ready to go!" -t 5000 &

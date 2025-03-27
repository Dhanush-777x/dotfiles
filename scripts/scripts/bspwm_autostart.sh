#!/bin/bash

# Show notification using dunstify
dunstify "Welcome Back Dhanush!" "Setting Up Your Workspace. Please Wait..." -t 5000 &

# Wait for a brief period after boot (instead of a fixed sleep)
sleep 1  # You can reduce this if you want it faster

# Open WhatsApp in the 6th workspace (background it)
gtk-launch com.brave.Browser.flextop.brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop &
sleep 2
bspc node -d 6

# Start two tmux sessions (background them)
tmux -u new-session -d -s Term        # Create Term session
tmux -u new-session -d -s nvim        # Create nvim session
tmux -u new-session -d -s yazi        # Create yazi session

# Open nvim inside the "nvim" session
tmux -u send-keys -t nvim "nvim" Enter
tmux -u detach -s nvim 

# Open nvim inside the "yazi" session
tmux -u send-keys -t yazi "yazi" Enter
tmux -u detach -s yazi 

# Open terminal in workspace 2 with the "Term" session
kitty --class "Term" -e tmux -u attach-session -t Term &
sleep 1  # Wait briefly for the terminal to launch

# Move it to workspace 3
bspc node -d 3

# Open Work Brave in the 2nd workspace (background)
flatpak run com.brave.Browser &
sleep 1  
bspc node -d 2

# Open Personal Brave in the 1st workspace (background)
flatpak run com.brave.Browser &
sleep 1  
bspc node -d 1

# Return focus to the first workspace
bspc desktop -f 2

# Ready to go notification
dunstify "Setting Up Done" "You are ready to go!" -t 5000 &

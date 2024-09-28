#!/bin/bash

# Get the currently playing song
song=$(playerctl metadata title)

# If there is no song playing, display "No Music"
if [[ -z "$song" ]]; then
    echo "No Music"
else
    echo "$song"
fi

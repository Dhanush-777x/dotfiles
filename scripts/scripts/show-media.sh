#!/bin/bash

media_info=$(playerctl metadata --format "{{artist}} - {{title}}" 2>/dev/null)

if [ -z "$media_info" ]; then
    media_info="No media playing"
fi

dunstify -u low "Now Playing" "$media_info"

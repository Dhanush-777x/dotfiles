#!/bin/bash

case "$1" in
    play)
        playerctl play
        ;;
    pause)
        playerctl pause
        ;;
    next)
        playerctl next
        ;;
    previous)
        playerctl previous
        ;;
    *)
        echo "Usage: $0 {play|pause|next|previous}"
        exit 1
        ;;
esac

#!/bin/bash

# Maximum length of the song title
max_length=30

# List of offline audio players to check
offline_players=("spotify" "rhythmbox" "audacious" "mpd" "deadbeef" "cmus")

# Get the currently active player
active_player=$(playerctl -l | grep -E "$(
  IFS=\|
  echo "${offline_players[*]}"
)" | head -n 1)

# Get the title of the currently playing track
if [ -n "$active_player" ]; then
  title=$(playerctl -p "$active_player" metadata title 2>/dev/null)
else
  title=""
fi

# Truncate the song title if it exceeds max_length
if [[ -n "$title" && ${#title} -gt $max_length ]]; then
  title="${title:0:max_length}..."
fi

# If there is no song playing, display "No Music"
if [[ -z "$title" ]]; then
  echo "No Music"
else
  echo "$title"
fi

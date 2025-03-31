
#!/bin/bash

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

#LOG_FILE="$HOME/.todoist_notify.log"
TASKS=$(/home/dhanushsm/.cargo/bin/doist list --nointeractive)
NOW=$(date +%s)

#echo "$(date): Checking tasks..." >> "$LOG_FILE"

echo "$TASKS" | while IFS= read -r line; do

     TASK_NAME=$(echo "$line" | sed -E 's/^[0-9]+ p[0-9] //; s/ [A-Z][a-z]{2} [0-9]+.*//; s/@[^ ]*//g; s/\[[^]]*\]//g; s/^ *//; s/ *$//')

    # Extract time (e.g., "15:08", "5pm", "10:30am")
    TASK_TIME=$(echo "$line" | grep -oE '[0-9]{1,2}:[0-9]{2}(am|pm)?|[0-9]{1,2}(am|pm)')

    if [[ -z "$TASK_TIME" ]]; then
        continue  # Skip tasks without a specific time
    fi

    #echo "$(date): Raw Task -> $line" >> "$LOG_FILE"
    #echo "$(date): Extracted Time -> $TASK_TIME" >> "$LOG_FILE"

    # Convert time to timestamp
    TASK_TIME_UNIX=$(date -d "$(date '+%Y-%m-%d') $TASK_TIME" +%s 2>/dev/null)

    #echo "$(date): Computed Task Timestamp -> $TASK_TIME_UNIX" >> "$LOG_FILE"

    if [[ -n "$TASK_TIME_UNIX" ]]; then
        THIRTY_MINS_BEFORE=$((TASK_TIME_UNIX - 1800))
        FIVE_MINS_BEFORE=$((TASK_TIME_UNIX - 300))

        #echo "$(date): 30 Min Before -> $THIRTY_MINS_BEFORE | 5 Min Before -> $FIVE_MINS_BEFORE | Now -> $NOW" >> "$LOG_FILE"

        if (( NOW >= THIRTY_MINS_BEFORE && NOW < THIRTY_MINS_BEFORE + 60 )); then
            (dunstify -u normal -t 10000 "$TASK_NAME" "⏳ 30 mins left!" & paplay "$HOME/.config/bspwm/sounds/gta5.mp3" &)
            #echo "$(date): 30 mins left for task -> $TASK_NAME" >> "$LOG_FILE"
        elif (( NOW >= FIVE_MINS_BEFORE && NOW < FIVE_MINS_BEFORE + 60 )); then
            (dunstify -u critical -t 10000 "$TASK_NAME" "🕐 5 mins left!" & paplay "$HOME/.config/bspwm/sounds/gta5.mp3" &)
            #echo "$(date): 5 mins left for task -> $TASK_NAME" >> "$LOG_FILE"
        fi
    fi
done

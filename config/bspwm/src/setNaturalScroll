#!/bin/bash
# Replace 'Your Mouse Name' with the actual device name from xinput list
DEVICE_NAME="MSFT0001:00 06CB:7F28 Touchpad"

# Find the device ID by name
DEVICE_ID=$(xinput list --id-only "$DEVICE_NAME")

# Enable natural scrolling (set property 1 for the 'libinput Natural Scrolling Enabled' option)
if [ ! -z "$DEVICE_ID" ]; then
    xinput set-prop "$DEVICE_ID" "libinput Natural Scrolling Enabled" 1
else
    echo "Device not found!"
fi


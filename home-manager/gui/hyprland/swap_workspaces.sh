#!/bin/bash

# Swap active workspaces between exactly 2 monitors in Hyprland

# Get monitor names
readarray -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')

# Ensure exactly 2 monitors
if [ "${#MONITORS[@]}" -ne 2 ]; then
    notify-send "Workspace Swap Error" \
        "This script requires exactly 2 monitors.\nDetected:\n${MONITORS[*]}" \
        -u critical
    exit 1
fi

MON1="${MONITORS[0]}"
MON2="${MONITORS[1]}"

notify-send "Swapping Workspaces" \
    "$MON1  ⇄  $MON2"

# Atomic swap (no new workspace creation)
if hyprctl dispatch swapactiveworkspaces "$MON1" "$MON2"; then
    notify-send "Workspace Swap" "Swap completed successfully."
else
    notify-send "Workspace Swap Failed" "An error occurred during swap." -u critical
fi

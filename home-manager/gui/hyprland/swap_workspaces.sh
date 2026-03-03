#!/bin/bash

# Swap active workspaces between exactly 2 monitors in Hyprland

# Get monitor names
readarray -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')

# Ensure exactly 2 monitors
if [ "${#MONITORS[@]}" -ne 2 ]; then
    echo "Error: This script requires exactly 2 monitors."
    echo "Detected monitors:"
    printf '%s\n' "${MONITORS[@]}"
    exit 1
fi

MON1="${MONITORS[0]}"
MON2="${MONITORS[1]}"

echo "Swapping active workspaces:"
echo "  $MON1 <-> $MON2"

# Atomic swap (no new workspace creation)
hyprctl dispatch swapactiveworkspaces "$MON1" "$MON2"

echo "Done."

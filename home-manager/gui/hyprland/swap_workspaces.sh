#!/bin/bash

MON_JSON=$(hyprctl monitors -j)
WS_JSON=$(hyprctl workspaces -j)

MON1=$(echo "$MON_JSON" | jq -r '.[0].name')
MON2=$(echo "$MON_JSON" | jq -r '.[1].name')

if [ -z "$MON1" ] || [ -z "$MON2" ]; then
    notify-send "Workspace Swap" "Could not detect monitors." -u critical
    exit 1
fi

# Save active workspaces for focus restoration
ACTIVE_WS1=$(echo "$MON_JSON" | jq -r '.[0].activeWorkspace.id')
ACTIVE_WS2=$(echo "$MON_JSON" | jq -r '.[1].activeWorkspace.id')

# Collect all workspace IDs per monitor before moving anything
WS_ON_MON1=$(echo "$WS_JSON" | jq -r --arg mon "$MON1" '.[] | select(.monitor == $mon) | .id')
WS_ON_MON2=$(echo "$WS_JSON" | jq -r --arg mon "$MON2" '.[] | select(.monitor == $mon) | .id')

###################################
# Move all MON1 workspaces -> MON2
###################################
for ws in $WS_ON_MON1; do
    hyprctl dispatch moveworkspacetomonitor "$ws" "$MON2"
done

###################################
# Move all MON2 workspaces -> MON1
###################################
for ws in $WS_ON_MON2; do
    hyprctl dispatch moveworkspacetomonitor "$ws" "$MON1"
done

###################################
# Restore active workspace per monitor
###################################
hyprctl dispatch focusmonitor "$MON1"
hyprctl dispatch workspace "$ACTIVE_WS2"

hyprctl dispatch focusmonitor "$MON2"
hyprctl dispatch workspace "$ACTIVE_WS1"

notify-send "Workspace Swap" "Workspaces swapped successfully."

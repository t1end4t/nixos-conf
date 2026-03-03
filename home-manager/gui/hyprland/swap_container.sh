#!/bin/bash

# Temporary workspace
TMP_WS=10

# Get monitor info once
MON_JSON=$(hyprctl monitors -j)

# Get workspace IDs on both monitors
WS1=$(echo "$MON_JSON" | jq -r '.[0].activeWorkspace.id')
WS2=$(echo "$MON_JSON" | jq -r '.[1].activeWorkspace.id')

if [ -z "$WS1" ] || [ -z "$WS2" ]; then
    echo "Could not detect workspaces."
    exit 1
fi

echo "Workspace on monitor1: $WS1"
echo "Workspace on monitor2: $WS2"
echo "Using temp workspace: $TMP_WS"

###################################
# Move window WS1 -> TMP
###################################
hyprctl dispatch workspace "$WS1"
hyprctl dispatch movetoworkspace "$TMP_WS"

###################################
# Move window WS2 -> WS1
###################################
hyprctl dispatch workspace "$WS2"
hyprctl dispatch movetoworkspace "$WS1"

###################################
# Move window TMP -> WS2
###################################
hyprctl dispatch workspace "$TMP_WS"
hyprctl dispatch movetoworkspace "$WS2"

###################################
# Restore focus to original WS2
###################################
hyprctl dispatch workspace "$WS2"

echo "Swap complete."

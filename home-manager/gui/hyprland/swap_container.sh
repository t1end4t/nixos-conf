#!/bin/bash

TMP_WS=10

MON_JSON=$(hyprctl monitors -j)

MON1=$(echo "$MON_JSON" | jq -r '.[0].name')
MON2=$(echo "$MON_JSON" | jq -r '.[1].name')

WS1=$(echo "$MON_JSON" | jq -r '.[0].activeWorkspace.id')
WS2=$(echo "$MON_JSON" | jq -r '.[1].activeWorkspace.id')

if [ -z "$WS1" ] || [ -z "$WS2" ]; then
    notify-send "Workspace Swap" "Could not detect workspaces." -u critical
    exit 1
fi

###################################
# Move WS1 -> TMP
###################################
hyprctl dispatch workspace "$WS1"
hyprctl dispatch movetoworkspace "$TMP_WS"

###################################
# Move WS2 -> WS1
###################################
hyprctl dispatch workspace "$WS2"
hyprctl dispatch movetoworkspace "$WS1"

###################################
# Move TMP -> WS2
###################################
hyprctl dispatch workspace "$TMP_WS"
hyprctl dispatch movetoworkspace "$WS2"

###################################
# Restore monitors properly
###################################
hyprctl dispatch focusmonitor "$MON1"
hyprctl dispatch workspace "$WS2"

hyprctl dispatch focusmonitor "$MON2"
hyprctl dispatch workspace "$WS1"

notify-send "Workspace Swap" "Workspaces swapped successfully."

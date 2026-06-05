#!/bin/bash

MON_JSON=$(hyprctl monitors -j)
CLIENT_JSON=$(hyprctl clients -j)

MON1=$(echo "$MON_JSON" | jq -r '.[0].name')
MON2=$(echo "$MON_JSON" | jq -r '.[1].name')

if [ -z "$MON1" ] || [ "$MON1" = "null" ] || [ -z "$MON2" ] || [ "$MON2" = "null" ]; then
    notify-send "Container Swap" "Could not detect two monitors." -u critical
    exit 1
fi

ACTIVE_WS1=$(echo "$MON_JSON" | jq -r '.[0].activeWorkspace.id')
ACTIVE_WS2=$(echo "$MON_JSON" | jq -r '.[1].activeWorkspace.id')

if [ -z "$ACTIVE_WS1" ] || [ "$ACTIVE_WS1" = "null" ] || [ -z "$ACTIVE_WS2" ] || [ "$ACTIVE_WS2" = "null" ]; then
    notify-send "Container Swap" "Could not detect active workspaces." -u critical
    exit 1
fi

CLIENTS_ON_WS1=$(echo "$CLIENT_JSON" | jq -r --argjson ws "$ACTIVE_WS1" '.[] | select(.workspace.id == $ws) | .address')
CLIENTS_ON_WS2=$(echo "$CLIENT_JSON" | jq -r --argjson ws "$ACTIVE_WS2" '.[] | select(.workspace.id == $ws) | .address')

dispatch() {
    hyprctl eval "hl.dispatch($1)"
}

for address in $CLIENTS_ON_WS1; do
    dispatch "hl.dsp.focus({ window = \"address:$address\" })"
    dispatch "hl.dsp.window.move({ workspace = $ACTIVE_WS2 })"
done

for address in $CLIENTS_ON_WS2; do
    dispatch "hl.dsp.focus({ window = \"address:$address\" })"
    dispatch "hl.dsp.window.move({ workspace = $ACTIVE_WS1 })"
done

dispatch "hl.dsp.focus({ monitor = \"$MON1\" })"
dispatch "hl.dsp.focus({ workspace = $ACTIVE_WS1 })"

dispatch "hl.dsp.focus({ monitor = \"$MON2\" })"
dispatch "hl.dsp.focus({ workspace = $ACTIVE_WS2 })"

notify-send "Container Swap" "Containers swapped successfully."

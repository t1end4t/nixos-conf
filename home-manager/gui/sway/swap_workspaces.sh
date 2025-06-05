#!/bin/sh
# Assume the 2 recent workspaces belong to 2 outputs
output_1_name=$(swaymsg -t get_outputs --raw | jq '.[0].name' -r)
output_2_name=$(swaymsg -t get_outputs --raw | jq '.[1].name' -r)
workspace_on_1=$(swaymsg -t get_outputs --raw | jq '.[0].current_workspace' -r)
workspace_on_2=$(swaymsg -t get_outputs --raw | jq '.[1].current_workspace' -r)

# Check if either variable is null
if [ "$workspace_on_1" = null ] || [ "$workspace_on_2" = null ]; then
    echo "One of the variables is null. Exiting..."
    exit 1  # Exit the script with a non-zero status
fi

# move workspace
swaymsg workspace number ${workspace_on_1:0:1}
swaymsg move workspace to output $output_2_name
swaymsg workspace number ${workspace_on_2:0:1}
swaymsg move workspace to output $output_1_name 

# move to main screen (workspace 2)
main_workspace=$(swaymsg -t get_outputs --raw | jq '.[1].current_workspace' -r)
swaymsg workspace number ${main_workspace:0:1}


#!/bin/sh
# This code used for swap 2 containers in 2 workspaces (in 2 different outputs),for better workflow  

# Get name of 2 workspaces
workspace_on_1=$(swaymsg -t get_outputs --raw | jq '.[0].current_workspace' -r)
workspace_on_2=$(swaymsg -t get_outputs --raw | jq '.[1].current_workspace' -r)
other_workspace=10 

# Check if either variable is null
if [ "$workspace_on_1" = null ] || [ "$workspace_on_2" = null ]; then
    echo "One of the variables is null. Exiting..."
    exit 1  # Exit the script with a non-zero status
fi

# move workspace
# move 1 -> 10, 2 -> 1 and 10 -> 2
move1to10(){
  swaymsg workspace number ${workspace_on_1:0:1}
  swaymsg move container to workspace number $other_workspace
}

move2to1(){
  swaymsg workspace number ${workspace_on_2:0:1}
  swaymsg move container to workspace number ${workspace_on_1:0:1}
}

move10to2(){
  swaymsg workspace number $other_workspace
  swaymsg move container to workspace number ${workspace_on_2:0:1}
}


main() {
    move1to10

    # Check if the command failed
    if [ $? -ne 0 ]; then
        echo "Command failed, can not move container from 1 to 10"
        move2to1
        if [ $? -ne 0 ]; then
            echo "Command failed, can not move container from 2 to 1"
            return
        else
            echo "Command succeeded."
        fi
        return
    else
        echo "Command succeeded."
    fi

    move2to1
    if [ $? -ne 0 ]; then
        echo "Command failed, can not move container from 2 to 1"
        move10to2
        return
    else
        echo "Command succeeded."
    fi

    move10to2
}


# Call the function
main

# to hide other_workspace
swaymsg workspace number ${workspace_on_1:0:1}

# move to main workspace (workspace 2)
main_workspace=$(swaymsg -t get_outputs --raw | jq '.[1].current_workspace' -r)
swaymsg workspace number ${main_workspace:0:1}

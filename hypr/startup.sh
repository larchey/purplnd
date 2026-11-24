#!/bin/bash
# Hyprland startup layout script
# Layout: Left top = terminal, Left bottom = btop, Right = firefox

sleep 1.5

# 1. Open firefox - takes full screen
firefox &
sleep 1.2

# 2. Open terminal - splits to the left
kitty &
sleep 0.8

# 3. Move terminal to the left
hyprctl dispatch movewindow l
sleep 0.3

# 4. Focus terminal (left side) and open btop below it
hyprctl dispatch movefocus l
sleep 0.3

kitty --class btop -e btop &

# 5. Open herdr on workspace 2 without leaving workspace 1. Attaches to the
#    existing herdr session or starts one; interactive bash so PATH etc. match
#    a normal terminal (agents launched by herdr inherit it).
hyprctl dispatch exec "[workspace 2 silent] kitty -e bash -ic 'exec $HOME/.local/bin/herdr'"

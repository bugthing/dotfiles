#!/bin/sh
#xrandr --output DP-2-3  --left-of DP-2-1 \
#       --output DP-2-1  --primary \
#       --output eDP-1   --right-of DP-2-1

xrandr --output DP-2-1 --auto --left-of eDP-1 --primary \
       --output DP-2-2 --auto --left-of DP-2-1 \
       --output eDP-1  --auto

#!/bin/sh
xrandr --output DP-2-3 --mode 1920x1080 --left-of DP-2-1 \
       --output DP-2-1 --mode 1920x1080 --primary \
       --output eDP-1  --mode 1920x1080 --right-of DP-2-1
#       --output eDP-1  --off

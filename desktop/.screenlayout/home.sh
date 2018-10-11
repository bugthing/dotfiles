#!/bin/sh
xrandr --output eDP-1  --mode 1920x1080 --right-of DP-2-3  --rotate normal --scale 0.7x0.7 \
       --output DP-2-1 --mode 1920x1080 --left-of DP-2-3  --rotate normal --primary \
       --output DP-2-3 --mode 1920x1080  --rotate normal \
       #--output eDP-1  --mode 3200x1800 --pos 3600x0 --rotate normal --scale 0.5x0.5 \
       #--output DP-2 --off --output DP-1 --off --output DP-1-3 --off

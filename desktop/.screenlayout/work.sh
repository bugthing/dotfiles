#!/bin/sh
xrandr --output eDP-1  --mode 3200x1800 --pos 0x0    --rotate normal --primary --scale 0.5x0.5 \
       --output DP-1-1 --mode 1920x1080 --pos 1600x0 --rotate normal \
       --output DP-1-3 --mode 1920x1080 --pos 3520x0 --rotate normal \
       --output DP-2 --off \
       --output DP-1 --off \
       --output DP-1-2 --off

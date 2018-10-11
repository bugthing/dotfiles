#!/bin/sh
xrandr --output eDP-1  --mode 1920x1080 --right-of DP-2-3  --rotate normal --scale 0.7x0.7 \
       --output DP-2-1 --mode 1920x1080 --left-of DP-2-3  --rotate normal --primary \
       --output DP-2-3 --mode 1920x1080  --rotate normal

#!/usr/bin/env bash

tmpbg='/tmp/screen.png'

lockargs=""

for output in `swaymsg -t get_outputs -r | jq -r '.[] | select(.active == true) | .name'`; do
  bgfile="${tmpbg}_${output}"
  grim -o ${output} -t png ${bgfile}
  convert ${bgfile} -scale 10% -scale 1000% ${bgfile}
  lockargs="${lockargs} --image=${output}:${bgfile}"
done

`swaylock --daemonize ${lockargs}`

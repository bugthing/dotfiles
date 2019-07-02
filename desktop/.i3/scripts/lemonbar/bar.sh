#!/usr/bin/bash

Date() {
  DATETIME=$(date "+%a, %b %d %Y")
  echo -n "$DATETIME"
}
Time() {
  DATETIME=$(date "+%T")
  echo -n "$DATETIME"
}
Battery() {
  dir="/sys/class/power_supply/BAT0/"
  status=$(cat $dir"status")
  capacity=$(cat $dir"charge_full_design")
  current=$(cat $dir"charge_now")
  percentage=$((current*100/capacity))
  echo $percentage"% "$status
}
Wifi() {
  echo "50%"
}
Network() {
  # The following assumes you have 3 interfaces: loopback, ethernet, wifi
  #read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]+: \(.*\):.*$/\1/p'`
  read lo int1 int2 <<<  `ip link | sed -n 's/^[0-9]\+: \(.*\):.*$/\1/p'`
  # iwconfig returns an error code if the interface tested has no wireless
  # extensions
  if iwconfig $int1 >/dev/null 2>&1; then
      wifi=$int1
      eth0=$int2
  else 
      wifi=$int2
      eth0=$int1
  fi
  echo $lo
  echo $wifi
  echo $eth0
  ## in case you have only one interface, just set it here:
  ## int=eth0
  ## this line will set the variable $int to $eth0 if it's up, and $wifi
  ## otherwise. I assume that if ethernet is UP, then it has priority over
  ## wifi. If you have a better idea, please share :)
  #ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi
  ## just output the interface name. Could obviously be done in the 'ping'
  ## query
  #echo -n "$int"
  ## Send a single packet, to speed up the test. I use google's DNS 8.8.8.8,
  ## but feel free to use any ip address you want. Be sure to put an IP, not a
  ## domain name. You'll bypass the DNS resolution that can take some precious
  ## miliseconds ;)
  ## synj - added -s1 to save data on metered connections
  #ping -c1 -s1 8.8.8.8 >/dev/null 2>&1 && echo "connected" || echo "disconnected"
}
Cpu() {
  TOP=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }')
  echo -n "$TOP"
}
Ram() {
  FREE=$(free | awk '/Mem/{printf("%.2f%"), $3/$2*100}')
  echo -n "$FREE"
}
Disk() {
  echo "105.4GB/500GB (20%)"
}
Volume() {
  pactl list sinks \
  | grep '^[[:space:]]Volume:' \
  | head -n $(( $SINK + 1 )) \
  | tail -n 1 \
  | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
}
WindowList() {
  # wmctrl -d
  echo "2: Tmux | 3: Chromium"
}

while true; do
  echo -e "%{F#00000000} %{B#00000000}" \
          "%{l}"                        \
          "%{F#FF69B4} %{B#000000}"     \
          "\uf2d0 $(WindowList)"        \
          "%{F#00000000} %{B#00000000}" \
          "%{F#FF69B4} \uf101"          \
          "%{c}"                        \
          "%{F#FF69B4} \uf100"          \
          "%{F#161821} %{B#a093c7}"     \
          "\uf1eb Wifi: $(Wifi)"        \
          "%{F#161821} %{B#e27878}"     \
          "\uf0e8 Net: $(Network)"      \
          "%{F#161821} %{B#89b8c2}"     \
          "\uf1b2 CPU: $(Cpu)"          \
          "%{F#161821} %{B#b4be82}"     \
          "\uf2db RAM: $(Ram)"          \
          "%{F#161821} %{B#84a0c6}"     \
          "\uf1b3 Disk: $(Disk)"        \
          "%{F#b4be82} %{B#161821}"     \
          "\uf028 Volume: $(Volume)"    \
          "%{F#FF69B4} %{B#c6c8d1}"     \
          "\uf242 $(Battery)"  \
          "%{F#00000000} %{B#00000000}" \
          "%{F#FF69B4} \uf101"          \
          "%{r}"                        \
          "%{F#FF69B4} \uf100"          \
          "%{F#89b8c2} %{B#161821}"     \
          "\uf073 $(Date)"              \
          "%{F#FFFFFF} %{B#89b8c2}"     \
          "\uf017 $(Time)"              \
          "%{F#00000000} %{B#00000000}"

  sleep 1;
done

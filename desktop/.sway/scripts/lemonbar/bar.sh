#!/usr/bin/bash

Date() {
  DATETIME=$(date "+%a %b %d")
  echo -n "$DATETIME"
}
Time() {
  DATETIME=$(date "+%T")
  echo -n "$DATETIME"
}
Battery() {
  #BATPERC=$(acpi --battery | cut -d, -f2)
  echo "50%"
}
Wifi() {
  echo "50%"
}
Network() {
  echo "192.168.1.1"
}
Cpu() {
  echo "10%"
}
Ram() {
  echo "5.4GB/8GB (70%)"
}
Disk() {
  echo "105.4GB/500GB (20%)"
}

while true; do
  echo -e "%{F#FF69B4}"\
          "%{l}"\
          "<WINDOW LIST>"\
          "\uf1eb Wifi: $(Wifi) \uf0e7 Net: $(Network)" \
          "\uf1b2 CPU: $(Cpu) \uf2db RAM: $(Ram) \uf1b3 Disk: $(Disk)" \
          "%{r}"\
          "\uf242 Battery: $(Battery) \uf133 $(Date) \uf017 $(Time)"

  sleep 1;
done

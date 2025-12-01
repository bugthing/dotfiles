# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# load all the custom shizzle
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

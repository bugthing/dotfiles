#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# start dbus
if [ -n $DBUS_SESSION_BUS_ADDRESS ]; then
    export $(dbus-launch)
fi

# start pulseaudio in the background
if [ -x /usr/bin/pulseaudio ]; then
    /usr/bin/pulseaudio --start
fi
# register pulseaudio
if [ -x /usr/bin/start-pulseaudio-x11 ]; then
    /usr/bin/start-pulseaudio-x11
fi

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(ssh-agent)

exec i3 -c $HOME/.sway/i3_config

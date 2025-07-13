#!/bin/bash

# Start dbus
mkdir -p /run/dbus
dbus-daemon --system --nofork &
sleep 2

# Start avahi daemon
avahi-daemon --no-drop-root --daemonize

# Start Xorg server
setsid Xorg :0 -nolisten tcp -novtswitch -noreset -sharevts > /tmp/xorg.log 2>&1 < /dev/null &
sleep 5

# Set DISPLAY env
export DISPLAY=:0

# Start window manager and VNC server
fluxbox &
x11vnc -display :0 -nopw -forever -shared -rfbport 5911 &
sleep 2

# Launch OBS Studio
exec obs

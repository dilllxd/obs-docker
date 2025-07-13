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

# Start window manager and VNC server in background
fluxbox &
x11vnc -display :0 -nopw -forever -shared -rfbport 5911 &
sleep 2

# Start noVNC proxy in background
/opt/novnc/utils/novnc_proxy --vnc localhost:5911 --listen 6080 &

# Run OBS as the main foreground process
exec obs

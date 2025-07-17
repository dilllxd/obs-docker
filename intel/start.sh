#!/bin/bash

cleanup() {
    echo "Cleaning up processes..."
    pkill -TERM -P $$  # kill all child processes
    # kill Xorg on :0 if still running
    XPID=$(pgrep -f "Xorg :0")
    if [[ -n "$XPID" ]]; then
        echo "Killing leftover Xorg process $XPID"
        kill -TERM $XPID
    fi
    exit 0
}

trap cleanup SIGINT SIGTERM

# Check for stale Xorg on :0 and kill if exists
XPID=$(pgrep -f "Xorg :0")
if [[ -n "$XPID" ]]; then
    echo "Found stale Xorg process $XPID, killing..."
    kill -TERM $XPID
    sleep 3
fi

# Start dbus
mkdir -p /run/dbus
dbus-daemon --system --nofork &
sleep 2

# Start avahi daemon
avahi-daemon --no-drop-root --daemonize

# Start Xorg server in foreground
Xorg :0 -nolisten tcp -novtswitch -noreset -sharevts > /tmp/xorg.log 2>&1 < /dev/null &

sleep 5

export DISPLAY=:0

# Start window manager and VNC server in background
fluxbox &
x11vnc -display :0 -nopw -forever -shared -rfbport 5911 &

sleep 2

# Start noVNC proxy in background
/opt/novnc/utils/novnc_proxy --vnc localhost:5911 --listen 6080 &

# Wait for main processes (OBS is foreground)
exec obs

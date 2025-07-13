# OBS + DistroAV Intel GPU Docker Image

This image runs OBS Studio with DistroAV and Intel GPU acceleration on Ubuntu 24.04.

## Build

```bash
docker build -t obs-distroav:intel .
```

## Run

```bash
docker run -it --rm \
  --network br0 \
  --device=/dev/dri \
  --shm-size=4g \
  --env DISPLAY=:0 \
  -p 5911:5911 \
  -v ~/.config/obs-studio:/root/.config/obs-studio \
  --name obs-intel \
  obs-distroav:intel
```

## Accessing the Container via VNC

1. Make sure port **5911** is accessible.
   - If running locally, connect your VNC client to `localhost:5911`.
   - If running the container on a remote machine, connect to the host’s IP address on port 5911, for example: 192.168.x.x:5911

2. Use any VNC viewer (like TigerVNC, RealVNC, or TightVNC) to connect.

3. The container runs a minimal X server environment with Fluxbox and x11vnc on port 5911 by default.

4. No password is set by default. For security, consider adding VNC password protection if exposing this port publicly.
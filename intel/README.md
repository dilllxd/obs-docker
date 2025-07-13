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
  -p 6080:6080 \
  -v ~/.config/obs-studio:/root/.config/obs-studio \
  --name obs-intel \
  ghcr.io/dilllxd/obs-distroav:intel
```

# Accessing the Container via VNC or webVNC

## webVNC Access (noVNC)

1. Make sure port **6080** is accessible.
   - If running locally, open your browser and navigate to `http://localhost:6080`.
   - If remote, navigate to `http://<host-ip>:6080`.

2. This provides web-based VNC access via noVNC.

3. The noVNC service proxies to the VNC server on port 5911 inside the container.

---

## VNC Access

1. Make sure port **5911** is accessible.
   - If running locally, connect your VNC client to `localhost:5911`.
   - If running the container on a remote machine, connect to the host’s IP address on port 5911, e.g., `192.168.x.x:5911`.

2. Use any VNC viewer such as:
   - TigerVNC
   - RealVNC
   - TightVNC

3. The container runs a minimal X server environment with Fluxbox and x11vnc on port 5911 by default.

4. No password is set by default. For security, consider adding VNC password protection if exposing this port publicly.

---

## Summary of Ports

| Service          | Port | Description                       |
|------------------|------|---------------------------------|
| VNC Server       | 5911 | For VNC clients (desktop apps)  |
| noVNC Web Access | 6080 | Web browser-based VNC client    |

---
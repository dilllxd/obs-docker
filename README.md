# OBS + DistroAV Docker Images for Intel & AMD GPUs

This repository contains Dockerfiles and instructions for running OBS Studio with DistroAV and GPU acceleration using Intel or AMD GPUs.

---

## Available Images

- `obs-distroav:intel` — Optimized for Intel GPUs 
- `obs-distroav:amd` — Optimized for AMD GPUs

---

## Running the Containers

Use the appropriate Docker run command depending on your GPU type.

### Intel GPU Example

```bash
docker run -it --rm \
  --network br0 \
  --device=/dev/dri \
  --shm-size=4g \
  --env DISPLAY=:0 \
  -p 5911:5911 \
  -v ~/.config/obs-studio:/root/.config/obs-studio \
  --name obs-intel \
  ghcr.io/dilllxd/obs-distroav:intel
```

### AMD GPU Example

```bash
docker run -it --rm \
  --network br0 \
  --device=/dev/dri \
  --shm-size=4g \
  --env DISPLAY=:0 \
  -p 5911:5911 \
  -v ~/.config/obs-studio:/root/.config/obs-studio \
  --name obs-amd \
  ghcr.io/dilllxd/obs-distroav:amd
```

---

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

## Important Notes

- You *cannot* run this container without a GPU attached to the container. Please do not report issues if you do not have a GPU attached.
- The containers require access to the host GPU via `/dev/dri`.
- Use the `br0` network bridge to enable proper NDI source discovery.
- Shared memory is set to 4GB to improve stability with OBS.
- OBS settings and profiles are persisted by mounting your local `~/.config/obs-studio` directory inside the container.
- Ensure proper permissions on `/dev/dri` devices on your host for container access.
- By default, the containers start a lightweight X server with Fluxbox and x11vnc on port 5911 to reduce potential conflicts.
- This setup supports Twitch’s Enhanced Broadcasting Beta, so if you’ve got a server with a supported GPU, you can offload your encoding to it and free up your main system!

---

## Potential Issues

- I don't have an AMD gpu to test the AMD image, ChatGPT said it should work so please report any issues or feel free to PR!
- I’d love to add NVIDIA GPU support, but I don’t have one anymore to test with or feel confident making a Dockerfile for it. If you want to help out, feel free to send a PR! My Dockerfiles are a good place to start.
- My testing environment is currently: Unraid 7.1.4, Intel Arc B580 with monitor connected through HDMI.

---

## Building the Images Locally

Clone this repo and build the desired image from its folder:

```bash
# For Intel GPU image
docker build -t obs-distroav:intel ./intel

# For AMD GPU image
docker build -t obs-distroav:amd ./amd
```

---

## Potential Roadmap:

- [x] ~~Web VNC Client in addition to VNC server to negate the need to have a VNC client installed locally.~~ _(added in v1.1.0)_
- [ ] More testing, I just don't have the resources to test on all different types of GPU's. I personally have a B580 that I've been using and it works amazingly. I might be able to test a 3060 and a RX 9070 XT in the near future but no promises ):
- [ ] CPU framebuffer support, I have tried this but have had varying success/issues. Low FPS on OBS was one of the main issues. But, experimenting wouldn't hurt.

---

## License

MIT License © 2025 dilllxd

This project is licensed under the MIT License — see the [LICENSE](./LICENSE) file for details.

---

## Credits

- OBS Studio: https://obsproject.com/  
- DistroAV: https://github.com/DistroAV/DistroAV  
- Intel and AMD GPU drivers and tools
- ChatGPT for dockerfile and debugging help

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
  obs-distroav:intel
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
  obs-distroav:amd
```

---

## Connecting via VNC

The containers start an X server environment with Fluxbox window manager and `x11vnc` running on port **5911** by default. This allows you to remotely access the desktop environment inside the container.

To connect:

1. Make sure port **5911** is accessible.  
   - If running locally, you can connect to `localhost:5911`.  
   - If you’re connecting remotely, ensure the network allows access to port 5911 on the host machine (you might need to forward or open the port depending on your setup).

2. Use any VNC client (e.g., RealVNC, TigerVNC, TightVNC) to connect to the container's IP on port 5911.

No password is set by default (for convenience), so be cautious if exposing the port publicly.

---

## Important Notes

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

1. Web VNC Client in addition to VNC server to negate the need to have a VNC client installed locally.
2. More testing, I just don't have the resources to test on all different types of GPU's. I personally have a B580 that I've been using and it works amazingly. I might be able to test a 3060 and a RX 9070 XT in the near future but no promises ):

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

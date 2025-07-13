# OBS + DistroAV Docker Images for Intel & AMD GPUs

This repository contains Dockerfiles and instructions for running OBS Studio with DistroAV and GPU acceleration using Intel or AMD GPUs.

---

## Available Images

- `obs-distroav:intel` — Optimized for Intel integrated GPUs  
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
  -v ~/.config/obs-studio:/root/.config/obs-studio \
  --name obs-amd \
  obs-distroav:amd
```

---

## Important Notes

- The containers require access to the host GPU via `/dev/dri`.
- Use the `br0` network bridge to enable proper NDI source discovery.
- Shared memory is set to 4GB to improve stability with OBS.
- OBS settings and profiles are persisted by mounting your local `~/.config/obs-studio` directory inside the container.
- Ensure proper permissions on `/dev/dri` devices on your host for container access.
- By default, the containers start a lightweight X server with Fluxbox and x11vnc on port 5911 to reduce potential conflicts.

---

## Potential Issues

- I don't have an AMD gpu to test the AMD image, ChatGPT said it should work so please report any issues or feel free to PR!
- I’d love to add NVIDIA GPU support, but I don’t have one anymore to test with or feel confident making a Dockerfile for it. If you want to help out, feel free to send a PR! My Dockerfiles are a good place to start.
- My testing environment is relatively unique: I'm running Unraid 7.1.4 and have a monitor connected directly to the GPU.

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

## License

MIT License © 2025 dilllxd

This project is licensed under the MIT License — see the [LICENSE](./LICENSE) file for details.

---

## Credits

- OBS Studio: https://obsproject.com/  
- DistroAV: https://github.com/DistroAV/DistroAV  
- Intel and AMD GPU drivers and tools
- ChatGPT for dockerfile and debugging help

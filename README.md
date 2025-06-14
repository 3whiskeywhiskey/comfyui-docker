# ComfyUI Docker Image (CUDA 12.1)

This repository builds and publishes a GPU‑enabled Docker image for ComfyUI.

* **Automatic:** GitHub Actions watches upstream releases; each new tag is built and pushed.
* **Reproducible:** build arg `COMFYUI_VERSION` is always pinned to a tag, never `main`.

## Usage

```bash
# pull the image built from the latest ComfyUI tag
docker pull ghcr.io/3whiskeywhiskey/comfyui:latest

# or pin explicitly
 docker pull ghcr.io/3whiskeywhiskey/comfyui:v0.3.40

# run (GPU)
 docker run --gpus all -p 7860:7860 ghcr.io/3whiskeywhiskey/comfyui:latest
```

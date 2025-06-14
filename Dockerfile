# syntax=docker/dockerfile:1.6
ARG COMFYUI_VERSION
FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-devel

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_PREFER_BINARY=1

# ---- system packages --------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ---- ComfyUI source ---------------------------------------------------
ARG COMFYUI_VERSION
ENV COMFY_ROOT=/opt/ComfyUI
RUN git clone --depth 1 --branch ${COMFYUI_VERSION} \
      https://github.com/comfyanonymous/ComfyUI.git ${COMFY_ROOT}
WORKDIR ${COMFY_ROOT}
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt

#COPY extra_model_paths.yaml ${COMFY_ROOT}/

ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    NVIDIA_VISIBLE_DEVICES=all \
    PYTHONPATH="${PYTHONPATH}:${PWD}" \
    CLI_ARGS=""

EXPOSE 7860
CMD ["bash","-c","python -u main.py --listen --port 7860 ${CLI_ARGS}"]

FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ARG VERSION
ENV VERSION=1.3.2

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update -y \
 && apt-get -qq install -y --no-install-recommends \
    git git-lfs libgl1 pkg-config python-is-python3 python3-dev python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch v${VERSION} -c advice.detachedHead=false \
    https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /app

WORKDIR /app

ENV PIP_NO_CACHE_DIR=true
ENV PIP_ROOT_USER_ACTION=ignore
RUN sed -i -e 's/    start()/    #start()/g' /app/launch.py \
 && python launch.py --skip-torch-cuda-test \
 && sed -i -e 's/    #start()/    start()/g' /app/launch.py

EXPOSE 7860

ENTRYPOINT ["python", "launch.py", "--listen", "--data-dir", "/app/data", "--disable-console-progressbars", "--enable-insecure-extension-access"]
CMD ["--api", "--opt-sdp-no-mem-attention", "--opt-channelslast"]

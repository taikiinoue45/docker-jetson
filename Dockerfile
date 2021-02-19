FROM nvcr.io/nvidia/l4t-base:r32.4.2

ENV DEBIAN_FRONTEND=noninteractive

RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            \
            # Basic apt packages
            cmake \
            build-essential \
            git \
            python3-pip \
            python3-dev \
            python3-numpy \
            \
            # Non-python dependencies for numpy or torch
            # https://github.com/numpy/numpy/blob/master/site.cfg.example
            libopenblas-dev \
            libopenmpi2 \
            openmpi-bin \
            openmpi-common \
            gfortran \
            \
            # Non-python dependencies for torchvision (pillow)
            # https://forums.developer.nvidia.com/t/pytorch-for-jetson-nano-version-1-5-0-now-available/72048
            # https://pillow.readthedocs.io/en/5.1.x/installation.html
            libjpeg-dev \
            zlib1g-dev \
            \
        && rm -rf /var/lib/apt/lists/* \
        && python3 -m pip install --upgrade pip \
        && pip3 install setuptools Cython wheel

# Download Torch WHL file
# https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-7-0-now-available/72048
# v1.7.0 https://nvidia.box.com/shared/static/cs3xn3td6sfgtene6jdvsxlr366m2dhq.whl (torch-1.7.0-cp36-cp36m-linux_aarch64.whl)
ARG TORCH_URL=https://nvidia.box.com/shared/static/cs3xn3td6sfgtene6jdvsxlr366m2dhq.whl
ARG TORCH_WHL=torch-1.7.0-cp36-cp36m-linux_aarch64.whl
RUN set -xe \
        && mkdir /root/whl \
        && wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate ${TORCH_URL} -O /root/whl/${TORCH_WHL} \
        && pip3 install /root/whl/${TORCH_WHL}

# Build TorchVision WHL file from souce code
ARG TORCHVISION_VERSION=v0.8.1
ARG TORCHVISION_WHL=torchvision-0.8.0a0+45f960c-cp36-cp36m-linux_aarch64.whl
RUN set -xe \
        && git clone -b ${TORCHVISION_VERSION} https://github.com/pytorch/vision /root/torchvision \
        && cd /root/torchvision \
        && python3 setup.py bdist_wheel \
        && cp /root/torchvision/dist/${TORCHVISION_WHL} /root/whl/${TORCHVISION_WHL} \
        && pip3 install /root/whl/${TORCHVISION_WHL}

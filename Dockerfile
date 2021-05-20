ARG TORCH_URL=https://nvidia.box.com/shared/static/p57jwntv436lfrd78inwl7iml6p13fzh.whl
ARG TORCH_WHL=torch-1.8.0-cp36-cp36m-linux_aarch64.whl
ARG TORCHVISION_BRANCH=v0.9.0
ARG TORCHVISION_WHL=torchvision-0.9.0-cp36-cp36m-linux_aarch64.whl

FROM nvcr.io/nvidia/l4t-base:r32.5.0 AS tmp
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root
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
# https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-8-0-now-available/72048
ARG TORCH_URL
ARG TORCH_WHL
RUN set -xe \
        && mkdir /root/whl \
        && wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate ${TORCH_URL} -O /root/whl/${TORCH_WHL} \
        && pip3 install /root/whl/${TORCH_WHL}

# Build TorchVision WHL file from souce code
ARG TORCHVISION_WHL
ARG TORCHVISION_BRANCH
RUN set -xe \
        && git clone -b ${TORCHVISION_BRANCH} https://github.com/pytorch/vision /root/torchvision \
        && cd /root/torchvision \
        && python3 setup.py bdist_wheel \
        && cp /root/torchvision/dist/$(basename dist/*.whl) /root/whl/${TORCHVISION_WHL} \
        && pip3 install /root/whl/${TORCHVISION_WHL}


FROM nvcr.io/nvidia/l4t-base:r32.5.0
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root
ARG TORCH_WHL
ARG TORCHVISION_WHL
COPY --from=tmp /root/whl/${TORCH_WHL} /root/whl/${TORCH_WHL}
COPY --from=tmp /root/whl/${TORCHVISION_WHL} /root/whl/${TORCHVISION_WHL}

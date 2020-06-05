# The coding style of this Dockerfile inherits from ubuntu:18.04
# https://github.com/tianon/docker-brew-ubuntu-core/blob/451851eab04432157249eb444d5a42714e2a7112/bionic/Dockerfile

ARG PYTORCH_IMAGE=inoue/jetson/pytorch:latest
ARG OPENCV_IMAGE=inoue/jetson/opencv:latest
ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.2

FROM ${OPENCV_IMAGE} as opencv
FROM ${PYTORCH_IMAGE} as pytorch
FROM ${BASE_IMAGE}

COPY --from=opencv /usr/local/lib/python3.6/dist-packages/ /usr/local/lib/python3.6/dist-packages/
COPY --from=pytorch /usr/local/lib/python3.6/dist-packages/ /usr/local/lib/python3.6/dist-packages/
COPY --from=pytorch /usr/local/cuda/bin/ /usr/local/cuda/bin/
COPY --from=pytorch /usr/local/cuda/lib64/ /usr/local/cuda/lib64/

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8

RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            \
            # Basic apt packages
            git \
            build-essential \
            python3-pip \
            python3-dev \
            \
            # Non-python dependencies for matplotlib
            # https://matplotlib.org/3.1.1/users/installing.html#dependencies
            python3-tk \
            \
            # Non-python dependencies for numpy or torch
            # https://github.com/numpy/numpy/blob/master/site.cfg.example
            # 
            libopenblas-dev \
            libopenmpi2 \
            openmpi-bin \
            openmpi-common \
            gfortran \
            \
            # Non-python dependencies for torchvision 
            # https://forums.developer.nvidia.com/t/pytorch-for-jetson-nano-version-1-5-0-now-available/72048
            libjpeg-dev \
            zlib1g-dev \
            \
        && rm -rf /var/lib/apt/lists/*


RUN set -xe \
        && pip3 install -y \
            # *
            setuptools     \
            Cython         \
            wheel          \
            fastprogress   \
            tensorboard    \
            tqdm           \
            # *
            pyyaml         \
            pandas         \
            matplotlib     \
            albumentations \
            onnx

# Environmental settings
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
ENV TERM xterm-256color
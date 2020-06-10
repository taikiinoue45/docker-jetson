# The coding style of this Dockerfile inherits from ubuntu:18.04
# https://github.com/tianon/docker-brew-ubuntu-core/blob/451851eab04432157249eb444d5a42714e2a7112/bionic/Dockerfile

FROM taikiinoue45/jetson:opencv-whl as opencv-whl
FROM taikiinoue45/jetson:torch-whl as torch-whl
FROM nvcr.io/nvidia/l4t-base:r32.4.2

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8

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
            \
            # Non-python dependencies for matplotlib
            # https://matplotlib.org/users/installing.html#build-requirements
            # https://matplotlib.org/3.1.1/users/installing.html#dependencies
            # https://stackoverflow.com/questions/60765231/i-installed-matplotlib-via-pip-but-when-i-try-to-import-matplotlib-to-pycharm-i
            # https://stackoverflow.com/questions/9829175/pip-install-matplotlib-error-with-virtualenv
            python3-tk \
            libpng-dev \
            libfreetype6-dev \
            pkg-config \
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
            # Non-python dependencies for torch2trt
            # https://github.com/NVIDIA-AI-IOT/torch2trt#option-2---with-plugins-experimental
            libprotobuf* \
            protobuf-compiler \
            ninja-build \
            \
            # Graph visualization in torch2trt
            # https://github.com/NVIDIA-AI-IOT/torch2trt/issues/130#issuecomment-545618736
            graphviz \
            xdg-utils \
            \
        && sudo apt autoremove -y \
        && sudo apt autoclean -y \
        && rm -rf /var/lib/apt/lists/*

ARG OPENCV_WHL=opencv_python_headless-4.3.0+3073e9e-cp36-cp36m-linux_aarch64.whl
ARG TORCH_WHL=torch-1.4.0-cp36-cp36m-linux_aarch64.whl
ARG TORCHVISION_WHL=torchvision-0.5.0a0+85b8fbf-cp36-cp36m-linux_aarch64.whl
COPY --from=opencv-whl /root/whl/$OPENCV_WHL /root/whl/$OPENCV_WHL
COPY --from=torch-whl /root/whl/$TORCH_WHL /root/whl/$TORCH_WHL
COPY --from=torch-whl /root/whl/$TORCHVISION_WHL /root/whl/$TORCHVISION_WHL
COPY requirements.txt requirements.txt

RUN set -xe \
        && python3 -m pip install --upgrade pip \
        && pip3 install --no-cache-dir wheel setuptools Cython \
        && pip3 install /root/whl/$OPENCV_WHL \
        && pip3 install /root/whl/$TORCH_WHL \
        && pip3 install /root/whl/$TORCHVISION_WHL \
        && pip3 install --no-cache-dir -r requirements.txt \
        && rm -rf /root/whl

# Install torch2trt
# https://github.com/TaikiInoue/torch2trt#option-2---with-plugins-experimental
RUN set -xe \
        && git clone https://github.com/NVIDIA-AI-IOT/torch2trt \
        && cd torch2trt \
        && python3 setup.py install --plugins \
        && cd .. \
        && rm -rf torch2trt

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
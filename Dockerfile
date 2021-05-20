ARG TORCH_WHL=torch-1.8.0-cp36-cp36m-linux_aarch64.whl
ARG TORCHVISION_WHL=torchvision-0.9.0-cp36-cp36m-linux_aarch64.whl
ARG TORCH2TRT_BRANCH=v0.2.0
ARG TORCH2TRT_WHL=torch2trt-0.2.0-py3-none-any.whl

FROM taikiinoue45/jetson:torch-1.8.0 AS torch-1.8.0
FROM nvcr.io/nvidia/l4t-base:r32.5.0 AS tmp
ENV DEBIAN_FRONTEND=noninteractive
ARG TORCH_WHL
ARG TORCHVISION_WHL
ARG TORCH2TRT_BRANCH
ARG TORCH2TRT_WHL
COPY --from=torch-1.8.0 /root/whl/$TORCH_WHL /root/whl/$TORCH_WHL
COPY --from=torch-1.8.0 /root/whl/$TORCHVISION_WHL /root/whl/$TORCHVISION_WHL
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
        && pip3 install --no-cache-dir setuptools Cython wheel \
        && pip3 install /root/whl/$TORCH_WHL \
        && pip3 install /root/whl/$TORCHVISION_WHL \
        && git clone -b $TORCH2TRT_BRANCH https://github.com/NVIDIA-AI-IOT/torch2trt /root/torch2trt \
        && cd /root/torch2trt \
        && python3 setup.py bdist_wheel \
        && cp /root/torch2trt/dist/$(basename dist/*.whl) /root/whl/${TORCH2TRT_WHL} \
        && pip3 install /root/whl/${TORCH2TRT_WHL}


FROM nvcr.io/nvidia/l4t-base:r32.5.0
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root
ARG TORCH2TRT_WHL
COPY --from=tmp /root/whl/${TORCH2TRT_WHL} /root/whl/${TORCH2TRT_WHL}

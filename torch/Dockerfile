ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.2
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

#
# install prerequisites (many of these are for numpy)
#
RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
                python3-pip \
                python3-dev \
                libopenblas-dev \
                libopenmpi2 \
                openmpi-bin \
                openmpi-common \
                gfortran \
        && rm -rf /var/lib/apt/lists/* \
        && pip3 install setuptools Cython wheel \
        && pip3 install numpy

#
# PyTorch (for JetPack 4.4 DP)
#
#  PyTorch v1.2.0 https://nvidia.box.com/shared/static/lufbgr3xu2uha40cs9ryq1zn4kxsnogl.whl (torch-1.2.0-cp36-cp36m-linux_aarch64.whl)
#  PyTorch v1.3.0 https://nvidia.box.com/shared/static/017sci9z4a0xhtwrb4ps52frdfti9iw0.whl (torch-1.3.0-cp36-cp36m-linux_aarch64.whl)
#  PyTorch v1.4.0 https://nvidia.box.com/shared/static/c3d7vm4gcs9m728j6o5vjay2jdedqb55.whl (torch-1.4.0-cp36-cp36m-linux_aarch64.whl)
#  PyTorch v1.5.0 https://nvidia.box.com/shared/static/3ibazbiwtkl181n95n9em3wtrca7tdzp.whl (torch-1.5.0-cp36-cp36m-linux_aarch64.whl)
#
ARG PYTORCH_URL=https://nvidia.box.com/shared/static/lufbgr3xu2uha40cs9ryq1zn4kxsnogl.whl	
ARG PYTORCH_WHL=torch-1.2.0-cp36-cp36m-linux_aarch64.whl

RUN set -xe \
        && wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate ${PYTORCH_URL} -O ${PYTORCH_WHL} \
        && pip3 install ${PYTORCH_WHL} --verbose \
        && rm ${PYTORCH_WHL}

#
# torchvision 0.4
#
ARG TORCHVISION_VERSION=v0.4.0
RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
                git \
                build-essential \
                libjpeg-dev \
                zlib1g-dev \
        && rm -rf /var/lib/apt/lists/* \
        && git clone -b ${TORCHVISION_VERSION} https://github.com/pytorch/vision torchvision \
        && cd torchvision \
        && python3 setup.py install \
        && cd .. \
        && rm -rf torchvision \

#
# Pillow 7.1.1
#
RUN pip3 install Pillow==7.1.1

# 
# PyCUDA
#
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
RUN pip3 install pycuda --verbose
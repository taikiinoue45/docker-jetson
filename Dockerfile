FROM nvcr.io/nvidia/l4t-base:r32.4.2

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8

# scikit-image requirements
# https://scikit-image.org/docs/dev/install.html#full-requirements-list
ARG WHL_DIR=/root/.cache/pip/wheels/95/df/81/38e2d698d8c3605baff734ff6a1fe1c277e920f5fd0bd0b29d
ARG WHL_NAME=scikit_image-0.17.2-cp36-cp36m-linux_aarch64.whl
RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            cmake \
            build-essential \
            git \
            python3-pip \
            python3-dev \
            python3-matplotlib \
        && rm -rf /var/lib/apt/lists/* \
        && python3 -m pip install --upgrade pip \
        && pip3 install setuptools Cython wheel \
        && pip3 install \
            numpy==1.19.3 \
            pandas==1.1.5 \
            Pillow==8.1.0 \
            scikit-learn==0.24.0 \
            scipy==1.5.4 \
        && pip3 install scikit-image==0.17.2 \
        && mkdir /root/whl \
        && cp $WHL_DIR/$WHL_NAME /root/whl/$WHL_NAME

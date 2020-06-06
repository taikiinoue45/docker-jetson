FROM nvcr.io/nvidia/l4t-base:r32.4.2

ENV DEBIAN_FRONTEND=noninteractive

RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            cmake \
            build-essential \
            git \
            python3-pip \
            python3-dev \
            python3-numpy \
        && rm -rf /var/lib/apt/lists/* \
        && python3 -m pip install --upgrade pip \
        && pip3 install setuptools Cython wheel

# Build OpenCV WHL file from souece code
ARG OPENCV_WHL=opencv_python_headless-4.3.0+3073e9e-cp36-cp36m-linux_aarch64.whl
RUN set -xe \
        && git clone https://github.com/skvark/opencv-python.git /root/opencv-python \
        && cd /root/opencv-python \
        && sed -i 's/get_build_env_var_by_name("headless")/True/g' setup.py \
        && python3 setup.py bdist_wheel \
        && mkdir /root/whl \
        && cp /root/opencv-python/dist/${OPENCV_WHL} /root/whl/${OPENCV_WHL} \
        && pip3 install /root/whl/${OPENCV_WHL}
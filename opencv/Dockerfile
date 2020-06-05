# syntax=docker/dockerfile:1.0

ARG BASE_IMAGE=nvcr.io/nvidia/l4t-base:r32.4.2
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cmake              \
        build-essential    \
        git                \
        python3-pip        \
        python3-dev        \
        python3-numpy   && \
    rm -rf /var/lib/apt/lists/*

# Avoid: ModuleNotFoundError: No module named 'pip._internal'
RUN pip3 install --user --upgrade pip
RUN pip3 install setuptools \
                 Cython     \
                 wheel          

RUN git clone https://github.com/skvark/opencv-python.git /root/opencv-python && \
    cd /root/opencv-python                                                    && \
    sed -i 's/get_build_env_var_by_name("headless")/True/g' setup.py          && \
    python3 setup.py install                                                  && \
    cd /root                                                                  && \ 
    rm -rf /root/opencv-python
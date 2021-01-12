# The coding style of this Dockerfile inherits from ubuntu:18.04
# https://github.com/tianon/docker-brew-ubuntu-core/blob/451851eab04432157249eb444d5a42714e2a7112/bionic/Dockerfile

FROM taikiinoue45/jetson:opencv-whl as opencv-whl
FROM taikiinoue45/jetson:torch-whl as torch-whl
FROM nvcr.io/nvidia/l4t-base:r32.4.2

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8


COPY requirements_apt.txt requirements_apt.txt
RUN set -xe \
        && apt-get update \
        && sed -i "s/#.*//g" requirements_apt.txt \
        && apt-get install -y --no-install-recommends $(cat requirements_apt.txt) \
        && sudo apt-get autoremove -y \
        && sudo apt-get autoclean -y \
        && rm -rf /var/lib/apt/lists/*


ARG OPENCV_WHL=opencv_python_headless-4.3.0+3073e9e-cp36-cp36m-linux_aarch64.whl
ARG TORCH_WHL=torch-1.7.0-cp36-cp36m-linux_aarch64.whl
ARG TORCHVISION_WHL=torchvision-0.8.0a0+45f960c-cp36-cp36m-linux_aarch64.whl
COPY --from=opencv-whl /root/whl/$OPENCV_WHL /root/whl/$OPENCV_WHL
COPY --from=torch-whl /root/whl/$TORCH_WHL /root/whl/$TORCH_WHL
COPY --from=torch-whl /root/whl/$TORCHVISION_WHL /root/whl/$TORCHVISION_WHL
COPY requirements_pip.txt requirements_pip.txt
RUN set -xe \
        && python3 -m pip install --upgrade pip \
        && pip3 install --no-cache-dir wheel setuptools \
        # Install order need to be specified
        # Before installing matplotlib==3.3.2, installing numpy==1.19.2 must be done.
        && cat requirements_pip.txt | xargs -n 1 -L 1 pip3 install --no-cache-dir -v \
        && pip3 install -v /root/whl/$OPENCV_WHL \
        && pip3 install -v /root/whl/$TORCH_WHL \
        && pip3 install -v /root/whl/$TORCHVISION_WHL \
        && rm -rf /root/whl


ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

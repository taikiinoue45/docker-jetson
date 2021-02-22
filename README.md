# scikit-image-0.17.2

[![build](https://github.com/taikiinoue45/docker-jetson/actions/workflows/build.yml/badge.svg?branch=scikit-image-0.17.2)](https://github.com/taikiinoue45/docker-jetson/actions/workflows/build.yml)

<br>

## How to Use in Dockerfile
```
FROM taikiinoue45/jetson:scikit-image-0.17.2 as scikit-image-0.17.2
ARG SCIKIT_IMAGE_WHL=scikit_image-0.17.2-cp36-cp36m-linux_aarch64.whl
COPY --from scikit-image-0.17.2 /root/whl/$SCIKIT_IMAGE_WHL /root/whl/$SCIKIT_IMAGE_WHL
```

# torch2trt-0.2.0

[![build](https://github.com/taikiinoue45/docker-jetson/actions/workflows/build.yml/badge.svg?branch=torch2trt-0.2.0)](https://github.com/taikiinoue45/docker-jetson/actions/workflows/build.yml)

<br>

## How to Use in Dockerfile
```
FROM taikiinoue45/jetson:torch2trt-0.2.0 as torch2trt-0.2.0
ARG TORCH2TRT_WHL=torch2trt-0.2.0-py3-none-any.whl
COPY --from=torch2trt-0.2.0 /root/whl/$TORCH2TRT_WHL /root/whl/$TORCH2TRT_WHL
```

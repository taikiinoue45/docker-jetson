## Pytorch on Jetson AGX Xavier

This repository stores Dockerfiles for building images in the [`taikiinoue/jetson`](https://hub.docker.com/repository/docker/taikiinoue45/jetson) DockerHub page. `taikiinoue45/jetson:xavier` image provides you cuda-pytorch environment on Jetson AGX Xavier. This is created with multi-stage build. `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv` are intermediate images for building torch- and opencv-whl files. Therefore, non-developer users don't need to pull `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv`.  

## How to Manage Dockerfile

## Pytorch on Jetson AGX Xavier

This repository provides Dockerfiles for building images of [`taikiinoue/jetson`](https://hub.docker.com/repository/docker/taikiinoue45/jetson) DockerHub page. `taikiinoue45/jetson:xavier` image gives you cuda-pytorch environment on Jetson AGX Xavier. This is created with multi-stage build. `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv` are intermediate images for building torch- and opencv-whl files. Therefore, non-developer users don't need to pull `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv`.  

<br>
<br>

## How to Manage Dockerfile

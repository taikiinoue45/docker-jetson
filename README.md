## Docker Images for Pytorch Deep Learning Framework on Jetson

`taikiinoue45/jetson:main` is created with multi-stage build. `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv` are intermediate images for installing torch and opencv. Therefore, non-developer users pull only `taikiinoue45/jetson:main`.  

<br>
<br>

Docker Image and Path to Dockerfile  
- `taikiinoue45/jetson:main`: main/Dockerfile
- `taikiinoue45/jetson:torch`: torch/Dockerfile
- `taikiinoue45/jetson:opencv`: opencv/Dockerfile  

<br>
<br>

## Docker Default Runtime
When building `taikiinoue45/jetson:torch`, you have to enable access to the CUDA compiler (nvcc). However, `docker build` doesn't support the runtime option ([this is a much-needed feature](https://github.com/NVIDIA/nvidia-docker/issues/595)), and so you have to change the default runtime setting by adding "default-runtime": "nvidia" to your `/etc/docker/daemon.json`.
```
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },

    "default-runtime": "nvidia"
}
```

<br>

Reboot your docker deamon
```
$ sudo systemctl restart docker
```

<br>

Check the default runtime setting
```
$ docker info 2> /dev/null | grep -i runtime
>>> Runtimes: nvidia runc
>>> Default Runtime: nvidia
```

## Docker Images for Pytorch Deep Learning Framework on Jetson

`taikiinoue45/jetson:main` is created with multi-stage build. `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv` are intermediate images for installing torch and opencv. Therefore, non-developer users pull only `taikiinoue45/jetson:main`.  
<br>
<br>
Docker Image and Path to Dockerfile  
- `taikiinoue45/jetson:main`: main/Dockerfile
- `taikiinoue45/jetson:torch`: torch/Dockerfile
- `taikiinoue45/jetson:opencv`: opencv/Dockerfile


## Docker Default Runtime
To enable access to the CUDA compiler (nvcc) during docker build operations, add "default-runtime": "nvidia" to your `/etc/docker/daemon.json` configuration file before attempting to build the containers:
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

You will then want to restart the Docker service or reboot your system before proceeding.
```
sudo systemctl restart docker
```

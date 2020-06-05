# docker-jetson

`taikiinoue45/jetson:main` is created with multi-stage build. `taikiinoue45/jetson:torch` and `taikiinoue45/jetson:opencv` are intermediate images for installing torch and opencv. Therefore, non-developer users pull only `taikiinoue45/jetson:main`. 
  
  
    
Docker Image and Path to Dockerfile
- `taikiinoue45/jetson:main`: main/Dockerfile
- `taikiinoue45/jetson:torch`: torch/Dockerfile
- `taikiinoue45/jetson:opencv`: opencv/Dockerfile

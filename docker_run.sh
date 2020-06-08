docker run --runtime nvidia -it --rm \
    --network host \
    --volume /home/inoue/mnt:/app/mnt \
    --workdir /app \
    --name xavier \
    --hostname docker-xavier \
    taikiinoue45/jetson:xavier \
    /bin/bash

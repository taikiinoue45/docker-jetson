docker_build:
		docker build -t taikiinoue45/jetson:xavier_v1 .

docker_run:
		docker run --runtime nvidia -it --rm \
			--network host \
			--volume ~/github:/app/github \
			--workdir /app \
			--name docker-xavier \
			--hostname docker-xavier \
			taikiinoue45/jetson:xavier \
			/bin/bash

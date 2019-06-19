### Build docker container

```bash
docker build -t new-nginx container -f Dockerfile.nginx .
```

### Run docker container

```bash
docker run -d -p 3000:80 new-nginx
```

Go to the `localhost:3000` and check if nginx is up and running

### Usefull docker commands

```bash
docker ps - show running containers
docker ps -a - show all running/stopped/exited containers
docker stats - show monitoring statistic
docke inspect - show full info about container or image in JSON format
docker build - build an image
docker run - run a new container
docker start/stop - starto and stop containers
docker images - show all docker images on you computer
docker rm - delete cotainer
docker rmi - delete image
docker logs - show logs of container
```

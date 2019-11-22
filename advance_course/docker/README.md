### Command from lesson

```bash
docker run ubuntu /bin/echo 'Hello world'
docker run -i -t --rm ubuntu /bin/bash
# -t присваивает псевдо-tty или терминал внутри нового контейнера.
# -i позволяет создавать интерактивное соединение, захватывая стандартный вход (STDIN) контейнера.
# —rm требуется для автоматического удаления контейнера при выходе из процесса. По умолчанию контейнеры не удаляются.
```

```bash
docker run --name daemon -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"
# —name daemon назначает имя новому контейнеру. Если вы его не укажете, имя сгенерируется и назначится автоматически.
# -d запускает контейнер в фоновом режиме («демонизирует» его).
docker exec -it <container-id> bash
```

### Run container with curl

```
FROM ubuntu:latest
RUN apt-get update
RUN apt-get install --no-install-recommends --no-install-suggests -y curl
ENV SITE_URL https://google.com/
WORKDIR /data
VOLUME /data
CMD sh -c "curl -L $SITE_URL > /data/results"
```

```bash
docker build . -t test-curl
docker run --rm -e SITE_URL=http://google.com -v <folder_on_your_PC>:/data test-curl
docker system prune - полная очистка системы. Удаление всез контейнеров и имаджей
```

### Run docker container

```bash
docker run -d --name test-nginx -p 3000:80 nginx
```

Go to the `localhost:3000` and check if nginx is up and running

### Build docker container

```bash
docker build -t new-nginx container -f Dockerfile.nginx .
```

### Usefull docker commands

```bash
docker ps - show running containers
docker ps -a - show all running/stopped/exited containers
docker stats - show monitoring statistic
docker inspect - show full info about container or image in JSON format
docker export - export container filesystem to an archive
docker commit -  commit all changes in sourse container to a new one
docker build - build an image
docker run - run a new container
docker start/stop - start and stop containers
docker images - show all docker images on you computer
docker rm - delete cotainer
docker rmi - delete image
docker stats - show monitoring stat of runing containers
docker logs - show logs of container
```

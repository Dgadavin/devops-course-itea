FROM nginx:stable

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html  /usr/share/nginx/html

ENV NGINX_VERSION=1.2
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "entrypoint.sh"]

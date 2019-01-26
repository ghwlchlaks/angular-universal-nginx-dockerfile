# nginx
FROM nginx:1.15
MAINTAINER choi

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

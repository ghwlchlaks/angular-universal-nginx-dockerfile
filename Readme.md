## angular universal  
```
FROM node
MAINTAINER choi

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY package*.json /usr/src/app/
RUN npm install
RUN npm install -g @angular/cli@7.1.4

COPY ./ /usr/src/app

EXPOSE 4000

RUN npm run build:ssr
CMD [ "npm", "run", "serve:ssr" ]
```

## nginx  
```
# nginx
FROM nginx:1.15
MAINTAINER choi

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
```

## nginx.conf  
```
upstream docker-angular {
  server angular:4000;
}
server {
  listen 80;
  location / {
    proxy_pass http://docker-angular;
  }
}
```

## docker-compose.yml  
```
version: "1.0"
services:
        angular:
                container_name: angular
                build: ./angular/
                ports:
                        - '4000:4000'
                environment:
                        - PORT=4000
                networks:
                        - backend
        nginx:
                container_name: nginx
                build: ./
                ports:
                        - '80:80'
                networks: 
                        - backend
                depends_on:
                        - angular
networks:
        backend:
                driver: bridge
```
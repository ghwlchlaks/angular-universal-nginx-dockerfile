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

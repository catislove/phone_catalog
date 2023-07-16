FROM node:18-alpine
EXPOSE 8090

WORKDIR /home/app

COPY package.json /home/app/
COPY package-lock.json /home/app/
COPY ./node_modules /home/app/node_modules
COPY ./schema /home/app
COPY . /home/app
RUN npm install
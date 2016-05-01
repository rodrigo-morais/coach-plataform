FROM node:4.4.3

COPY ./package.json /app/package.json

WORKDIR /app

RUN npm install

COPY ./ /app

EXPOSE 3000

CMD npm run api
FROM node:4.4.3
COPY ./package.json /app/package.json
WORKDIR /app
RUN npm install
COPY ./ /app
CMD npm run api
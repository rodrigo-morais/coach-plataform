FROM node:4.4.3
COPY ./package.json /app/package.json
COPY ./elm-package.json /app/elm-package.json
WORKDIR /app
RUN npm install && npm install elm -g && elm-package install -y && npm install -g http-server
COPY ./ /app
CMD npm run build && npm run api &
WORKDIR /app/dist
CMD http-server -a 0.0.0.0 -p 9999
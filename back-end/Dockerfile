FROM node:4.4.3
<<<<<<< 1359a59b24af3182a0ac7070497e8822482a7495

COPY ./package.json /app/package.json

WORKDIR /app

RUN npm install

COPY ./ /app

EXPOSE 3000

=======
COPY ./package.json /app/package.json
WORKDIR /app
RUN npm install
COPY ./ /app
>>>>>>> Configuring project to works on local machine and local Docker using IP to Mac OS x as 192.162.99.100.
CMD npm run api
FROM ubuntu:12.04

# Set language
RUN locale-gen en_US.UTF-8

# Install NodeJS
RUN apt-get update
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install nodejs -y

# Install GHC
RUN apt-get install python-software-properties -y
RUN apt-get install apt-file -y
RUN apt-file update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:hvr/ghc -y
RUN apt-get update
RUN apt-get install cabal-install-1.22 ghc-7.10.2 ghc-7.10.2-dyn ghc-7.10.2-htmldocs ghc-7.10.2-prof -y
ENV PATH $HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.2/bin:$PATH
RUN cabal update

# Install Git
RUN apt-get install git -y

# Copy Elm and package JSON
COPY ./package.json /app/package.json
COPY ./elm-package.json /app/elm-package.json

# Run NPM and ELM-PACKAGE install
WORKDIR /app
RUN npm install && npm install elm@0.16.0 -g && elm-package install -y && npm install -g http-server
COPY ./ /app

RUN npm run build

WORKDIR /app/dist
CMD http-server -a 0.0.0.0 -p 9999
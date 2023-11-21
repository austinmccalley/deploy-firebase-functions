FROM node:18 as builder

## Install build toolchain, install node deps and compile native add-ons
RUN apt install -y python make g++

RUN npm install firebase-tools yarn

FROM node:alpine as app

## Copy built node modules and binaries without including the toolchain
COPY --from=builder node_modules .

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]

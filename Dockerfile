FROM node:12-slim
RUN apt-get update || : && apt-get install python -y
RUN npm install -g firebase-tools
COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]

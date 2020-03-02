FROM node:10.19
EXPOSE 8080
COPY server.js .
CMD [ "node", "server.js" ]
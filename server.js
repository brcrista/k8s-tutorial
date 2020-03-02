const http = require('http');

function onRequest(request, response) {
    console.log(`Received request for URL: ${request.url}`);

    response.writeHead(200);
    response.end('Hello world');
};

const port = 8080;
const server = http.createServer(onRequest);
server.listen(port);
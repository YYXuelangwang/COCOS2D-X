// var http = require('http');
// http.createServer(
//     function(req, res){
//         res.writeHead(200, {
//             'Content-Type':'text/plain'
//         });
//         res.end('Hello World\n');
//     }
// ).listen(3000, '127.0.0.1');

var webSocketServer = require('ws').Server;
var wss = new webSocketServer({port: 3000});
wss.on('connection', function(ws){
    ws.send('Hello World');
    ws.on('message', function(data){
        console.log(data);
    });
});


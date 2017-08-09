

/*服务端消息发送分
    notification : 提示信息
    message : 聊天内容（包含一个id， 昵称， 消息内容)
*/

function wsSend(type, client_uuid, nickname, message) {
    for (var i = 0; i < clients.length; i++){
        var clientSocket = clients[i].ws;
        if (clientSocket.readyStats === WebSocket.OPEN){
            clientSocket.send(JSON.stringify({
                "type":type,
                "id":client_uuid,
                "nickname":nickname,
                "message":message
            }));
        }
    }
}


var webSocketServer = require('ws').Server;
var wss = new webSocketServer({port: 8183});

wss.on('connection', function(ws){
    var client_uuid = uuid.v4();
    var nickname = "AnonymousUser" + clientIndex;
    clientIndex += 1;
    clients.push({"id":client_uuid, "ws":ws, "nickname":nickname});
    console.log('client[%s] connected', client_uuid);
    var connect_message = nickname + " has connected";
    wsSend("notificatio", client_uuid, nickname, connect_message);
    console.log('client [%s] connected', client_uuid);
    ws.on('message', function(message){
        if(message.indexOf('/nick') == 0){
            var nickname_array = message.split(' ');
            if (nickname_array.length >= 2) {
                var old_nickname = nickname;
                nickname = nickname_array[1];
                var nickname_message = "Client " + old_nickname + " changed to " + nickname;
                wsSend("nick_update", client_uuid, nickname, nickname_message);
            }
        }else{
            wsSend("message", client_uuid, nickname, message);
        }
    });

    var closeSocket = function(customMessage) {
        for (var i = 0; i < clients.length; i++){
            if ( clients[i].id == client_uuid){
                var disconnect_message;
                if (customMessage) {
                    disconnect_message = customElements;
                }else{
                    disconnect_message = nickname + " has disconneced";
                }

                wsSend("notification", client_uuid, nickname, disconnect_message);
                clients.splice(i, 1);
            }
        }
    };

    ws.on('close', function(){
        closeSocket();
    });
})


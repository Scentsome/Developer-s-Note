var app = require('http').createServer(handler) 
	, io = require('socket.io').listen(app)
	, fs = require('fs');
app.listen(8124);

function handler (req, res) { 
	fs.readFile(__dirname + '/chat.html', function (err, data) {
		if (err) { res.writeHead(500);
		return res.end('Error loading chat.html'); }
	res.writeHead(200);
	res.end(data); });
}
io.sockets.on('connection', function (socket) {
	socket.on('addme',function(jsonMessage) {
		socket.username = jsonMessage.name;
		var toClient = { sender : "SERVER", message : "Good to see your "+ jsonMessage.name};
		socket.emit('chat', toClient);
		toClient.message =  jsonMessage.name + " is on the Desk";
		socket.broadcast.emit('chat', toClient);
	});
	socket.on('sendchat', function(data) { 
		io.sockets.emit('chat', { sender : socket.username, message : data.message});
	});

	socket.on('disconnect', function() {
		var bye = { sender : "SERVER", message : socket.username+"has left the building"};
		io.sockets.emit('chat', bye);
	});
});
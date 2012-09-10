var app = require('http').createServer(handler) , io = require('socket.io').listen(app), fs = require('fs')
var counter;
app.listen(8124);

function handler (req, res) { 
	fs.readFile(__dirname + '/index.html', function (err, data) {
		if (err) {
			res.writeHead(500);
			return res.end('Error loading index.html');
		}
		counter = 1; 
		res.writeHead(200); 
		res.end(data);
	}); 
}
io.sockets.on('connection', function (socket) { 
	socket.emit('news', { news: 'world' }); 
	socket.on('echo', function (data) {
		if (counter <= 50) { 
			counter++;
			data.back+=counter;
			socket.emit('news', {news: data.back}); 
		}
	}); 
});
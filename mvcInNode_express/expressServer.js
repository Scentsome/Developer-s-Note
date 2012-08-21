var express = require("express");
var app = express();
app.get('/', function(req, res) { 
	res.send("<h1>Hello Express Server</h1>");
	res.end();
}); 
app.get('/index', function(req, res) { 
	res.send("<h1>Hello Express Server</h1>");
	res.end();
});
app.get('/send', function(req, res) { 
	var message = "<h1>Welcome to Express Server</h1>";
	var name = req.query.name;
	var age = req.query.age;
	if (name) {
		message = message +"<p> Hello "+name+"</p>";
	}
	if (age) {
		message = message +"<p> You are "+age+" years old.</p>";
	}
	res.send(message);
	res.end();
}); 
app.listen(8800);
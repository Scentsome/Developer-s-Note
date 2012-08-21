var express = require("express");
var app = express();
app.use(express.bodyParser());
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
app.post('/formData', function(req, res) { 
	res.send("<h1>Hello "+ req.body.username+"</h1>");
	res.end();
});
app.listen(8800);
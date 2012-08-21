var express = require("express");
var app = express();
app.use(express.bodyParser());
app.use(express.static(__dirname + '/public'));
app.set('view engine', 'jade');
app.set('views', __dirname+"/views" );


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

app.get('/hello', function(req, res) { 
	res.render("hello", {title:"Jade Demo", username:"Michael"});
	res.end();
});

app.listen(8800);
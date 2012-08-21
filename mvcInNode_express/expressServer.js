var express = require("express");
var app = express();
app.get('/', function(req, res) { 
	res.send("Hello Express Server");
	res.end();
}); 

app.listen(8800);
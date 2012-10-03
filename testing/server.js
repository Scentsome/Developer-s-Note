var express = require("express");
var app = express();

app.listen(8800);

app.get("/hello", function  (req, res) {
	res.write("hello world");
	res.end();
});
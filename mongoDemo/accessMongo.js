var express = require("express");
var app = express();
app.listen(8800);

var config = {
	"hostname":"localhost",
	"port":27017,
	"db":"mydb"
}

var dbURL = "mongodb://" + config.hostname + ":" + config.port + "/" + config.db;
var collections = ["users"];

var db = require("mongojs").connect(dbURL, collections);

app.get("/create",function  (req, res) {
	db.users.save({name: "Michael", gender: "Male"}, function(err, saved) {
	  if( err || !saved ) console.log("User not saved");
	  else {
		  res.send("User saved");
		  
	  }
	  res.end();
	});
	
});

app.get("/read",function  (req, res) {
	db.users.find({}, function(err, users) {
	  if( err || !users) console.log("No  users found");
	  else users.forEach( function(user) {
	    res.send(JSON.stringify(user)+"\n");
	  } );
	  res.end();
	});
});


app.get("/update",function  (req, res) {
	db.users.update({name: "Michael"}, {$set: {name: "James"}}, function(err, updated) {
	  if( err || !updated ) console.log("User not updated");
	  else {
		  res.send("User updated");
		  res.end();
	  }
	});
});

app.get("/remove",function  (req, res) {
	db.users.remove({gender: "Male"});
	res.send("removed ");
	res.end();
});
var express = require('express');

var app = express( );
app.configure(function() {
	    app.use(express.bodyParser({uploadDir: './'}));
});
app.listen(8800);
var fs=require('fs');
app.get('/data', function(req,res) {
	if (req.query.fileName) {
		
		var filename = req.query.fileName;
	    console.log(filename);
    
		
		fs.stat(filename, function(error, stat) {
		  if (error) { throw error; }
		  res.writeHead(200, {
		    'Content-Type' : 'application/zip',
		    'Content-Length' : stat.size
		  });
		  // do your piping here
		}); 

	    var fileStream = fs.createReadStream(filename);

	    fileStream.on('data', function (data) {
	        res.write(data);
	    });
	    fileStream.on('end', function() {
	        res.end();
	    });
		
	}else{
		res.writeHead(404,{"Content-Type": "application/zip"});
		res.write("error");
		res.end();
	}
});
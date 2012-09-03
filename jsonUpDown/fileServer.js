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
    
//	    var mimeType = "image/png";
//	    res.writeHead(200, mimeType);
		
		
		fs.stat(filename, function(error, stat) {
		  if (error) { throw error; }
		  res.writeHead(200, {
		    'Content-Type' : 'image/png',
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
app.get('/upload', function(req, res) {
	res.write('<html><body><form method="post" enctype="multipart/form-data" action="/fileUpload">'
    +'<input type="file" name="uploadingFile"><br>'
    +'<input type="submit">'
    +'</form></body></html>');
	res.end();
});
app.post('/fileUpload', function(req, res) {
//	console.log(req.body);
	console.log(req.files);
	var uploadedFile = req.files.uploadingFile;
		var tmpPath = uploadedFile.path;
		var fileSize = uploadedFile.size ;
		var targetPath = './' + uploadedFile.name;

		fs.rename(tmpPath, targetPath, function(err) {
			if (err) throw err;
			fs.unlink(tmpPath, function() {
//			if (err) throw err;
				console.log('File Uploaded to ' + targetPath + ' - ' + fileSize + ' bytes');
			});
		});
  	res.send('file upload is done.');
	res.end();
});

app.get('/json', function  (req, res) {
	if(req.query.data){
		console.log("got data"+req.query.data);
		res.send(JSON.stringify({name:"Michael", profession:"tutor"}));
	}else{
		res.send('<form method="post" action="/json">'
		+'<input value="michael" name="name"/><br>'
		+'<input type="password" value="12345" name="password"/><br>'
		+'<input type="submit"/>'
		+'</form>'
		);
		
	}
	res.end();
});

app.post('/json',function  (req, res) {
	if (req.body) {
		console.log("got json"+req.body);
		if (req.body.data) {
			var values = JSON.parse(req.body.data);
			console.log(values);
			res.send("got name : "+values["name"]+" password : "+ values["password"]);
		};
	};
	res.end();
});
var express = require('express');

var app = express( );
app.configure(function() {
	    app.use(express.bodyParser({uploadDir: './'}));
});
app.listen(8800);

app.get('/data', function(req,res) {
	if (req.query.fileName) {
		
		var filename = req.query.fileName;
	    console.log(filename);
    
	    var mimeType = "image/png";
	    res.writeHead(200, mimeType);

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
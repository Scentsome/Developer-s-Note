var fs = require("fs");

function listDir (dirName, callBack) {
	fs.readdir(dirName, function  (err, files) {
		if(err){
			callBack(err);
			return;
		}
		var dirs = [];
		for (var i = files.length - 1; i >= 0; i--) {
			fs.stat(dirName+"/"+files[i], function  (err, stats) {
				if(stats.isDirectory()){
					dirs.push(files[i]);
				}
			});
		};
		callBack(null, dirs);
	});
}


listDir(".",function  (err, dirs) {
	if(!err){
		console.log("got folders "+dirs);
	}else{
		console.log("error occurs");
	}
});
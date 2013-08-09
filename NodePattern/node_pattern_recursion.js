var fs = require("fs");

function listDir (rootDir, callBack) {
	fs.readdir(rootDir, function  (err, files) {
		if(err){
			callBack(err);
			return;
		}
		var dirs = [];	
		(function iterator (index) {
			if(index < files.length){
				fs.stat(rootDir+"/"+files[index], function  (err, stats) {
					if (err) {
						callBack(err);
						return;
					};
					if(stats.isDirectory()){
						dirs.push(files[index]);
					}
					iterator(index+1);
				});
			}else{
				callBack(null, dirs);
			}
		})(0);
	});
}


listDir(".",function  (err, dirs) {
	if(!err){
		console.log("got folders : "+dirs);
	}else{
		console.log("error occurs : "+ err);
	}
});
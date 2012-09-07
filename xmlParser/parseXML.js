var libxmljs = require("libxmljs");
var fs = require('fs');
fs.readFile("hello.html", 'utf8', function(err, data) {
  if (err) throw err;
  
  // console.log(data);

  var xmlDoc = libxmljs.parseXmlString(data);

  // xpath queries
  var gchild = xmlDoc.find('//td');
  
  for (var i = 0; i < gchild.length; i++){
  	console.log(gchild[i].text());
  };
  
  var xpath = '//tr[td = "Apples"]';
  
  var tr = xmlDoc.get(xpath);
  
  console.log("Up node is : " + tr.text());
  
  console.log("Child nodes : "+tr.childNodes());
  
  console.log("Next nodes : "+tr.childNodes()[1].text());
});




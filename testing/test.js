var assert = require("assert")
var request = require("request");
describe('Array', function(){
  describe('#indexOf()', function(){
    it('should return -1 when the value is not present', function(){
      assert.equal(-1, [1,2,3].indexOf(5));
      assert.equal(-1, [1,2,3].indexOf(0));
    })
  })
  
  
})

describe('http', function(){
    it("should respond with hello world", function(done) {
       request("http://localhost:8800/hello", function(error, response, body){
		   if (!error && response.statusCode == 200) {
         	  expect(body).toEqual("hello world");
         	 done();
	 		}
       });
     });
});
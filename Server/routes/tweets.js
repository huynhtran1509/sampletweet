var dbDriver = require("../module/db.js");
exports.list = function(req, res){

	dbDriver.openAndAuthDatabase(dbDriver,function(err,db){
		if(err)
		{
			console.log(err);
			res.end();
		}
		else {
			var tweet = require("../module/tweet.js");
			tweet.getAll(db,1,function(err,list) {
				dbDriver.closeDatabase();
				if(!err)
				{
					res.send(list);
				}
				
				res.end();
			});


		}
	});// end of dbDriver

};

exports.newtweet = function(req, res){

	dbDriver.openAndAuthDatabase(dbDriver,function(err,db){
		if(err)
		{
			dbDriver.closeDatabase();
			console.log(err);
			res.end();
		}
		else {
			var username = req.body.username;
			if(req.body.username== null || username =="")
			{
				dbDriver.closeDatabase();
				res.status(400);
				res.end("Username is required");
			}

			var avatar_url = req.body.avatar_url;
			if(req.body.avatar_url== null || avatar_url =="")
			{
				avatar_url = "http://localhost:3000/images/redpanda.png";
			}
			

			var message = req.body.message;
			if(req.body.message== null || message =="")
			{
				dbDriver.closeDatabase();
				res.status(400);
				res.end("message is required");
			}

			var tweet = require("../module/tweet.js");

			var user = {
				username : username,
				avatar_url:avatar_url
			}
			tweet.newtweet(user,message,db,function(err,docs){
				dbDriver.closeDatabase();
				if(err)
				{
					console.log(err);
					res.end();
				}
				else {
					res.send(docs[0]);
					res.end();
				}
			});
			res.end();
		}
	});//close open and auth database
}

exports.deletetweet = function(req, res){

	dbDriver.openAndAuthDatabase(dbDriver,function(err,db){

		var tweet_id = req.params.id;
		if(req.params.id == null || tweet_id =="")
		{
			dbDriver.closeDatabase();
			res.status(400);
			res.end("id is required");
		}
		else if(tweet_id != null && tweet_id.length != 24)
		{
			dbDriver.closeDatabase();
			res.status(400);
			res.end("id is not correct");

		}
		else {
			var tweet = require("../module/tweet.js");
			tweet.delete(tweet_id,db,function(err,removed) {
			dbDriver.closeDatabase();
			if(err)
			{
				console.log(err);
				res.end();
			}
			else {
				console.log("removed");
				res.end();
			}
		});
		}
		
		
		
	});
}
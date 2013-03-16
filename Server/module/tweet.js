exports.getAll =function (db,page,callback)
{
	var collection = db.collection("tweets");
	var cursor = collection.find();
	var skip = 0;
	var perPage = 20;
	skip = (page-1) * perPage;
	cursor.limit(perPage).skip();
	cursor.sort({timestamp:-1}).toArray(function(err, docs) {
		if(err)
		{
			console.log("ERROR in GET ALL BRANCHES");
			return callback(err);
		}
		else {
			return callback(null,docs);
		}

	});
};

exports.newtweet =function (user,message,db,callback)
{
	var collection = db.collection("tweets");
	
	var d = new Date();
	var curr_hour = d.getHours();
	var curr_min = d.getMinutes();
	var curr_second = d.getSeconds();
	var curr_date = d.getDate();
	var curr_month = d.getMonth();
	var curr_year = d.getFullYear();

	var datetime = curr_hour + ":"+curr_min + ":"+curr_second+ " "+ curr_date +"/"+curr_month+"/"+curr_year;

	var tweet = {
		message : message,
		timestamp: d.getTime(),
		datetime : datetime,
		user : {
			 username : user.username,
			 avatar_url : user.avatar_url
		}
	};

	collection.insert(tweet,function(err, docs) {
		if(err)
		{
			callback(err);
		}
		else {
			callback(null,docs);
		}
	});
}

exports.delete = function(tweet_id,db,callback)
{
	var collection = db.collection("tweets");
	var mongo = require('mongodb');
	var BSON = mongo.BSONPure;
	var o_id = new BSON.ObjectID(tweet_id);
	
	collection.remove({'_id':o_id},function(err,removed)
	{
		if(err)
		{
			console.log("Remove Error")
			return callback(err);
		}
		else {
			var json = {};
			return callback(null,json);
		}
	});//end of collection remove
}
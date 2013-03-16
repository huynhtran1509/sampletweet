##Receive timeline

GET /

###Response

	[
	    {
	        "message": "Ok. Time to finish it. LOL! ;)\nThis is amazing.\nYes, it's.",
	        "timestamp": 1363361412216,
	        "datetime": "23:30:12 15/2/2013",
	        "user": {
	            "username": "saturngod",
	            "avatar_url": "http://graph.facebook.com/htainlinshwe/picture"
	        },
	        "_id": "51433e844127850e05000003"
	    },
	    {
	        "message": "test",
	        "timestamp": 1363360812105,
	        "datetime": "23:20:12 15/2/2013",
	        "user": {
	            "username": "saturngod",
	            "avatar_url": "http://graph.facebook.com/htainlinshwe/picture"
	        },
	        "_id": "51433c2cd0e7b8ba04000004"
	    }
	]

##Post new tweet

POST /

**message**	STRING
**username** STRING
**avatar_url** STRING
 
###Response

	{
	        "message": "Ok. Time to finish it. LOL! ;)\nThis is amazing.\nYes, it's.",
	        "timestamp": 1363361412216,
	        "datetime": "23:30:12 15/2/2013",
	        "user": {
	            "username": "saturngod",
	            "avatar_url": "http://graph.facebook.com/htainlinshwe/picture"
	        },
	        "_id": "51433e844127850e05000003"
	  }
	  
##Delete post

DELETE /:id


###Response

	{}
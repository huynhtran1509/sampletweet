//
//  Post.h
//  sampletweet
//
//  Created by Htain Lin Shwe on 12/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
/*
 "message": "Hi ! this is testing",
 "timestamp": 1363100972506,
 "datetime": "23:9:32 12/2/2013",
 "user": {
 "username": "saturngod",
 "avatar_url": "http://localhost:3000/images/redpanda.png"
 },
 "_id": "513f452cd963b15f07000001"
 */
@interface Post : NSObject
@property(readonly) NSString* message;
@property(readonly) NSString* datetime;
@property(readonly) User* user;
@property(readonly) NSString* post_id;
@property(readonly) double timestamp;

-(id)initWithAttributes:(NSDictionary*)attribute;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

+(void)newTweet:(User*)user AndMessage:(NSString*)message WithBlock:(void (^)(Post *post, NSError *error))block;

+(void)deleteTweetWithID:(NSString*)tweet_id WithBlock:(void (^)( NSError *error))block;
@end

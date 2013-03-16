//
//  Post.m
//  sampletweet
//
//  Created by Htain Lin Shwe on 12/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import "Post.h"
#import "sampleTweetAPIClient.h"

@interface Post()
@property(nonatomic,readwrite) NSString* message;
@property(nonatomic,readwrite) NSString* datetime;
@property(nonatomic,readwrite) User* user;
@property(nonatomic,readwrite) NSString* post_id;
@property(nonatomic,readwrite) double timestamp;
@end
@implementation Post

-(id)initWithAttributes:(NSDictionary *)attribute {
    self = [super init];
    if (!self) {
        return nil;
    }
    _message = [attribute valueForKeyPath:@"message"];
    _datetime = [attribute valueForKeyPath:@"datetime"];
    _post_id = [attribute valueForKeyPath:@"_id"];
    _timestamp = [[attribute valueForKeyPath:@"timestamp"] doubleValue];
    
    _user = [[User alloc] initWithAttributes:[attribute valueForKeyPath:@"user"]];
    return self;
}

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    
    [[sampleTweetAPIClient sharedClient] getPath:@"/" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            Post *post = [[Post alloc] initWithAttributes:attributes];
            [mutablePosts addObject:post];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    
}

+(void)newTweet:(User*)user AndMessage:(NSString*)message WithBlock:(void (^)(Post *post, NSError *error))block {
    NSString* username = user.username;
    NSDictionary* params = @{@"username":username,@"avatar_url":[user.avatarImageURL absoluteString],@"message":message};
    
    [[sampleTweetAPIClient sharedClient] postPath:@"/" parameters:params success:^(AFHTTPRequestOperation *operation, id json) {
        
        Post* post = [[Post alloc] initWithAttributes:json];
        if (block) {
            block(post, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+(void)deleteTweetWithID:(NSString*)tweet_id WithBlock:(void (^)( NSError *error))block {
    
    [[sampleTweetAPIClient sharedClient] deletePath:[NSString stringWithFormat:@"/%@",tweet_id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(block)
        {
            block(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(block)
        {
            block(error);
        }
    }];
}
@end

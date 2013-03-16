//
//  User.m
//  sampletweet
//
//  Created by Htain Lin Shwe on 12/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import "User.h"
@interface User()
@property (nonatomic,readwrite) NSString* username;
@property (nonatomic,strong) NSString* avatarImageURLString;
@end
@implementation User
-(id)initWithAttributes:(NSDictionary*)attribute {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _username = [attribute valueForKey:@"username"];
    _avatarImageURLString = [attribute valueForKey:@"avatar_url"];

    return self;
}

- (NSURL *)avatarImageURL {
    NSLog(@"Avatar %@ .",_avatarImageURLString);
    return [NSURL URLWithString:_avatarImageURLString];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"Username :%@ , Avatar_URL :%@",_username,_avatarImageURLString];
    
}
@end

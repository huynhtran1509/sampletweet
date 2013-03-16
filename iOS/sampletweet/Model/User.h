//
//  User.h
//  sampletweet
//
//  Created by Htain Lin Shwe on 12/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,readonly) NSString* username;
@property (readonly, nonatomic, unsafe_unretained) NSURL *avatarImageURL;

-(id)initWithAttributes:(NSDictionary*)attribute;
@end

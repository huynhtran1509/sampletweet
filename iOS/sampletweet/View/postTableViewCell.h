//
//  postTableViewCell.h
//  sampletweet
//
//  Created by Htain Lin Shwe on 14/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Post;
@interface postTableViewCell : UITableViewCell
@property (nonatomic,strong) Post *post;
+ (CGFloat)heightForCellWithPost:(Post *)post;
@end

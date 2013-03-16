//
//  newPostViewController.h
//  sampletweet
//
//  Created by Htain Lin Shwe on 14/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class newPostViewController;
@protocol tweetsViewControllerDelegate <NSObject>
@required
-(void)completedTweedWithViewController:(newPostViewController*)viewcontroller;
-(void)dismissTweedWithViewController:(newPostViewController*)viewcontroller;
@end


@interface newPostViewController : UIViewController
@property (nonatomic,assign) IBOutlet UITextView* messageView;
@property (nonatomic,assign) id<tweetsViewControllerDelegate> delegate;
@end

//
//  newPostViewController.m
//  sampletweet
//
//  Created by Htain Lin Shwe on 14/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import "newPostViewController.h"
#import "User.h"
#import "Post.h"
@interface newPostViewController ()

@end

@implementation newPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

-(void)setupUI
{
    self.title = @"New Tweet";
    
    UIBarButtonItem* tweet = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleDone target:self action:@selector(newtweet)];
    self.navigationItem.rightBarButtonItem = tweet;
    
    UIBarButtonItem* close = [[UIBarButtonItem alloc] initWithTitle:@"close" style:UIBarButtonItemStyleBordered target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItem  = close;
    
    [self.messageView becomeFirstResponder];
}

-(void)newtweet
{
    NSDictionary* userData = @{@"username": @"saturngod",@"avatar_url":@"http://graph.facebook.com/htainlinshwe/picture"};
    
    User* user = [[User alloc] initWithAttributes:userData];
    
    [Post newTweet:user AndMessage:self.messageView.text WithBlock:^(Post *post, NSError *error) {
        
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            
            if([self.delegate respondsToSelector:@selector(completedTweedWithViewController:)])
            {
                [self.delegate completedTweedWithViewController:self];
            }
            
        }
    }];
}

-(void)close
{
    if([self.delegate respondsToSelector:@selector(dismissTweedWithViewController:)])
    {
        [self.delegate dismissTweedWithViewController:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

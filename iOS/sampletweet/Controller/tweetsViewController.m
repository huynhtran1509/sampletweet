//
//  tweetsViewController.m
//  sampletweet
//
//  Created by Htain Lin Shwe on 12/3/13.
//  Copyright (c) 2013 comquas. All rights reserved.
//

#import "tweetsViewController.h"
#import "ISRefreshControl.h"
#import "Post.h"
#import "postTableViewCell.h"

@interface tweetsViewController ()
@property(nonatomic,strong) NSMutableArray *posts;
@end

@implementation tweetsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.refreshControl = (id)[[ISRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
    [self refresh];
    self.title = @"Sample Tweets";
    [self setupUI];
}

-(void)setupUI
{
    UIBarButtonItem* addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(newpost)];
    self.navigationItem.rightBarButtonItem = addItem;
}

-(void)newpost
{
    newPostViewController* newpost = [[newPostViewController alloc] initWithNibName:@"newPostViewController" bundle:nil];
    newpost.delegate = self;
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:newpost];
    
    [self.navigationController presentModalViewController:nav animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [SVProgressHUD show];
        Post* post = [_posts objectAtIndex:indexPath.row];
        [Post deleteTweetWithID:post.post_id WithBlock:^(NSError* error){
            [SVProgressHUD dismiss];
            if(error == nil)
            {
                [_posts removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        }];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    postTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[postTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.post = [_posts objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [postTableViewCell heightForCellWithPost:[_posts objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Refresh
- (void)refresh
{
    [Post globalTimelinePostsWithBlock:^(NSArray* posts,NSError* error) {

        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            _posts = [NSMutableArray arrayWithArray:posts];
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
        
    }];

}

#pragma mark - newPostViewControllerDelegate

-(void)completedTweedWithViewController:(newPostViewController*)viewcontroller {
 
    [viewcontroller dismissModalViewControllerAnimated:YES];
    
    //call refreshNew after 0.8 seconds
    [self performSelector:@selector(refershNew) withObject:nil afterDelay:0.8];
}

-(void)refershNew
{
    [self.refreshControl beginRefreshing];
    [self refresh];
}

-(void)dismissTweedWithViewController:(newPostViewController*)viewcontroller {
    
    [viewcontroller dismissModalViewControllerAnimated:YES];
    
}
@end

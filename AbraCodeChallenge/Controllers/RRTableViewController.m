//
//  RRTableViewController.m
//  AbraCodeChallenge
//
//  Created by darshan on 4/26/15.
//  Copyright (c) 2015 Abra. All rights reserved.
//

#import "RRTableViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "NSDate+Utils.h"
static NSString * const RRBasicCellIdentifier = @"RRBasicCell";
@interface RRTableViewController ()
{
    NSMutableArray *posts;
    RRBlog *blog;
}
@end

@implementation RRTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
-(void) setup {
    posts = [NSMutableArray new];
    blog = [RRBlog new];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRBasicCell *cell = [self.tableView dequeueReusableCellWithIdentifier:RRBasicCellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(RRBasicCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    RRPost *post = [posts objectAtIndex:indexPath.row];
    [self setTitleForCell:cell item:post];
    [self setSubtitleForCell:cell item:post];
    [self setImageForCell:cell item:post];
}

- (void)setTitleForCell:(RRBasicCell *)cell item:(RRPost *)item {
    NSString *title = item.name ?: NSLocalizedString(@"", nil);
    [cell.captionLabel setText:title];
}

- (void)setSubtitleForCell:(RRBasicCell *)cell item:(RRPost *)item {
    NSString *subtitle = item.caption ?: NSLocalizedString(@"", nil);;
    if (subtitle.length > 200) {
        subtitle = [NSString stringWithFormat:@"%@...", [subtitle substringToIndex:200]];
    }
    [cell.detailLabel setText:[NSString stringWithFormat:@"%@ %@ %@",(NSDate*)[item.datePosted longDateString], (NSDate*)[item.datePosted shortTimeString], subtitle]];
}

- (void)setImageForCell:(RRBasicCell *)cell item:(RRPost *)item {
    if (item.imageUrl != nil) {
        [cell.imageView setImageWithURL:item.imageUrl];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark - Helpers
-(void)refreshData {
    [self fetchData];
}
- (void)reloadTableViewContent {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    });
}

-(void)fetchData {
    __weak typeof(self) weakSelf = self;
    [[TMAPIClient sharedInstance] posts:@"abratest" type:nil parameters:nil callback:^(id result, NSError *error) {
        if (!error) {
            NSDictionary *blogPosts = [result copy];
            NSString *lastUpdated = (NSString*)[blog updated];
            [blogPosts enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([key isEqualToString:@"posts"])
                {
                    [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        [weakSelf setPosts:obj];
                    }];
                }
                else if ([key isEqualToString:@"blog"])
                {
                    [weakSelf setBlog:obj];
                }
            }];
            if (lastUpdated != nil)
            {
                if(![lastUpdated isEqual:[blog updated]])
                {
                    [weakSelf reloadTableViewContent];
                }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"No new posts to update.", nil) preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:actionCancel];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            } else
            {
                [weakSelf reloadTableViewContent];
            }
        } else
        {
            NSLog(@"Error: %@", error);
        }
    }];
}

-(void) setPosts:(id)obj
{
    RRPost *post = [RRPost new];
    [post parseResponse:obj];
    [posts addObject:post];
}

-(void) setBlog:(id)obj
{
    [blog parseResponse:obj];
}

@end

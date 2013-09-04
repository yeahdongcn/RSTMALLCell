//
//  RSTMALLTableViewController.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSTMALLTableViewController.h"

@interface RSTMALLTableViewController ()<UIDynamicAnimatorDelegate>

- (void)__RSInitialize;

@end

@implementation RSTMALLTableViewController

#pragma mark - Private

- (void)__RSInitialize
{
    self.dataArray = [[NSMutableArray alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self __RSInitialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.tableView];
        _animator.delegate = self;
    }
    return _animator;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator
{
    NSLog(@"dynamicAnimatorWillResume:");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator
{
    NSLog(@"dynamicAnimatorDidPause:");
}

@end

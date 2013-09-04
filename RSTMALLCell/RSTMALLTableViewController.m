//
//  RSTMALLTableViewController.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSTMALLTableViewController.h"

#import "RSTMALLData.h"

#import "RSTMALLCell.h"

#import "RSTMALLImageView.h"

@interface RSTMALLTableViewController () <UIDynamicAnimatorDelegate, RSTMALLImageViewDelegate>

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
    
    self.isViewLoaded = YES;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.tableView];
        _animator.delegate = self;
    }
    return _animator;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSString *cellIdentifier = self.cellIdentifier;
    if (!cellIdentifier) {
        cellIdentifier = CellIdentifier; // Use 'Cell' as default cell indentifier
    }
    
    id c = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    int row = [indexPath row];
    id object = self.dataArray[row];
    
    // RSTMALLData -> RSTMALLCell
    if ([object isKindOfClass:[RSTMALLData class]]) {
        RSTMALLData *data = object;
        RSTMALLCell *cell = c;
        cell.titleLabel.text = data.title;
        cell.contentLabel.text = data.content;
        for (int i = 0; i < [data.images count]; i++) {
            RSTMALLImageView *imageView = (RSTMALLImageView *)[self.tableView viewWithTag:(row + 1) * 1000 + i];
            if (!imageView) {
                imageView = [[RSTMALLImageView alloc] initWithImage:data.images[i]];
                imageView.tag = (row + 1) * 1000 + i;
                imageView.delegate = self;
                [imageView sizeToFit];
                [self.tableView addSubview:imageView];
            }
            CGRect frame = imageView.frame;
            frame.origin.x = floorf((cell.bounds.size.width - cell.border.bounds.size.width) / 2.0f + cell.border.bounds.size.width - (cell.imagesPlaceHolderWidth + frame.size.width) / 2.0f);
            frame.origin.y = floorf((cell.bounds.size.height - frame.size.height) / 2.0f);
            if (i == 0) {
                frame.origin.x += 5;
                frame.origin.y += 5;
            } else if (i >= 2) {
                frame.origin.x -= 5;
                frame.origin.y -= 5;
            }
            frame.origin.x += cell.frame.origin.x;
            frame.origin.y += cell.frame.origin.y;
            if (!imageView.isFalling) {
                imageView.frame = frame;
            }
        }
    }
    
    return c;
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator
{
    NSLog(@"dynamicAnimatorWillResume:");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator
{
    NSLog(@"dynamicAnimatorDidPause:");
}

#pragma mark - RSTMALLImageViewDelegate

- (void)didClick:(RSTMALLImageView *)imageView
{
    NSLog(@"didClick:");
}

- (void)didFall:(RSTMALLImageView *)imageView
{
    NSLog(@"didFall:");
}

@end

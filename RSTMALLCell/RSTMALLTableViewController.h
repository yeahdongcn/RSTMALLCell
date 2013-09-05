//
//  RSTMALLTableViewController.h
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSTMALLImageView.h"

@interface RSTMALLTableViewController : UITableViewController <RSTMALLImageViewDelegate>

@property (nonatomic, assign) BOOL isViewLoaded;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, assign) CGFloat flyingDistance;

@property (nonatomic, assign) NSTimeInterval flyingDurationBase;

@property (nonatomic, assign) NSTimeInterval flyingStep;

+ (NSIndexPath *)indexPathForImageView:(RSTMALLImageView *)imageView;

+ (int)indexForImageVIew:(RSTMALLImageView *)imageView;

+ (NSUInteger)imageViewTagOffset;

+ (CGFloat)imageViewFrameOffset;

@end

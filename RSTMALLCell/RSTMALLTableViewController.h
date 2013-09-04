//
//  RSTMALLTableViewController.h
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTMALLTableViewController : UITableViewController

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *cellIdentifier;

@end

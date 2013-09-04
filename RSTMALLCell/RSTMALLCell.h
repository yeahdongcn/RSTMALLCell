//
//  RSTMALLCell.h
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellBackgroundColor [[UIColor lightGrayColor] colorWithAlphaComponent:0.5]

@interface RSTMALLCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView  *border;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;

@end

//
//  RSTMALLImageView.h
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSTMALLImageView : UIImageView

@property (nonatomic, assign) BOOL isFalling;

@property (nonatomic, assign) BOOL isLast;

- (void)restore;

@end

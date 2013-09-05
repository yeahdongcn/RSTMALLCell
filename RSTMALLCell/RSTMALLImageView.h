//
//  RSTMALLImageView.h
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSTMALLImageView;

@protocol RSTMALLImageViewDelegate <NSObject>

@optional

- (void)willFall:(RSTMALLImageView *)imageView;

- (void)didClick:(RSTMALLImageView *)imageView;

- (void)willReset:(RSTMALLImageView *)imageView;

@end

@interface RSTMALLImageView : UIImageView

@property (nonatomic, assign) BOOL isFalling;

@property (nonatomic, assign) BOOL isLast;

@property (nonatomic, weak) id<RSTMALLImageViewDelegate> delegate;

- (void)reset;

@end

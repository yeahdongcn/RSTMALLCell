//
//  RSTMALLImageView.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSTMALLImageView.h"

#import "RSTMALLTableViewController.h"

@interface RSTMALLImageView ()

@property (nonatomic, assign) CGSize offset;

@property (nonatomic, assign) CGPoint oldCenter;

@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;

@property (nonatomic, assign) BOOL isClicked;

@end

@implementation RSTMALLImageView

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        // Initialization code
        self.isLast = NO;
        self.isFalling = NO;
        self.isClicked = YES;
        
        self.dragThreshold = 5.0f;
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (UITableView *)tableView
{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UITableView class]]) {
            return (UITableView *)responder;
        }
    }
    return nil;
}

- (RSTMALLTableViewController *)tableViewController
{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[RSTMALLTableViewController class]]) {
            return (RSTMALLTableViewController *)responder;
        }
    }
    return nil;
}

- (BOOL)isGravityBehaviorNotNil
{
    return (_gravityBehavior != nil);
}

- (UIGravityBehavior *)gravityBehavior
{
    if (!_gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self]];
    }
    return _gravityBehavior;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [[self tableView] setScrollEnabled:NO];
    
    self.layer.zPosition = NSIntegerMax - 1;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[self superview]];
    self.offset = CGSizeMake(self.center.x - point.x, self.center.y - point.y);
    self.oldCenter = CGPointMake(self.center.x, self.center.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [[self tableView] setScrollEnabled:YES];

    if (self.isClicked) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClick:)]) {
            [self.delegate didClick:self];
        }
    } else {
        if (ABS(self.oldCenter.x - self.center.x) <= self.dragThreshold
            || ABS(self.oldCenter.y - self.center.y) <= self.dragThreshold) {
            [UIView animateWithDuration:[[UIApplication sharedApplication] statusBarOrientationAnimationDuration] animations:^{
                self.center = self.oldCenter;
            }];
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(willFall:)]) {
                [self.delegate willFall:self];
            }
            if (self.isLast) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(willReset:)]) {
                    [self.delegate willReset:self];
                }
            } else {
                [[self tableViewController].animator addBehavior:self.gravityBehavior];
                self.userInteractionEnabled = NO;
                self.isFalling = YES;
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    self.isClicked = NO;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[self superview]];
    point.x += self.offset.width;
    point.y += self.offset.height;
    self.center = point;
}

- (void)reset
{
    self.isLast = NO;
    self.isFalling = NO;
    self.isClicked = YES;
    self.layer.zPosition = 0;
    self.userInteractionEnabled = YES;
    if ([self isGravityBehaviorNotNil]) {
        [[self tableViewController].animator removeBehavior:self.gravityBehavior];
    }
}

@end

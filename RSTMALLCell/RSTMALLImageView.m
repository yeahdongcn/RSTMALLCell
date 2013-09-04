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

@property (nonatomic, assign) CGFloat zPosition;

@property (nonatomic, assign) CGSize offset;

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
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        self.userInteractionEnabled = YES;
    }
    return self;
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
    
    self.zPosition = self.layer.zPosition;
    self.layer.zPosition = NSIntegerMax - 1;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[self superview]];
    self.offset = CGSizeMake(self.center.x - point.x, self.center.y - point.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [[self tableView] setScrollEnabled:YES];

    if (self.isClicked) {
        // TODO: check touch point.
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClick:)]) {
            [self.delegate didClick:self];
        }
        self.isClicked = YES;
    } else {
        if (!self.isLast) {
            [[self tableViewController].animator addBehavior:self.gravityBehavior];
            self.isFalling = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFall:)]) {
                [self.delegate didFall:self];
            }
        } else {
            [self reset];
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
    self.layer.zPosition = self.zPosition;
    if ([self isGravityBehaviorNotNil]) {
        [[self tableViewController].animator removeBehavior:self.gravityBehavior];
    }
}

@end

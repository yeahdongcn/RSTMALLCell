//
//  RSViewController.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSViewController.h"

#import "RSTMALLCell.h"

#import "RSTMALLData.h"

#import "RSTMALLImageView.h"

@interface RSViewController ()



@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.backgroundView.backgroundColor = kCellBackgroundColor;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 10; i++) {
            @autoreleasepool {
                RSTMALLData *data = [[RSTMALLData alloc] init];
                data.title = @"This is a title";
                data.content = @"This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text. This is a text.";
                NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:5];
                for (int i = 1; i <= 5; i++) {
                    [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
                }
                data.images = [NSArray arrayWithArray:images];
                data.countOfRemainingImages = [data.images count];
                [self.dataArray addObject:data];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RSTMALLCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    int row = [indexPath row];
    RSTMALLData *data = self.dataArray[row];
    cell.titleLabel.text = data.title;
    cell.contentLabel.text = data.content;
    for (int i = 0; i < [data.images count]; i++) {
        RSTMALLImageView *iv = (RSTMALLImageView *)[self.tableView viewWithTag:(row + 1) * 1000 + i];
        if (!iv) {
            iv = [[RSTMALLImageView alloc] initWithImage:data.images[i]];
            iv.tag = (row + 1) * 1000 + i;
            [iv sizeToFit];
            [self.tableView addSubview:iv];
        }
        CGRect frame = iv.frame;
        frame.origin.x = floorf((cell.bounds.size.width - cell.border.bounds.size.width) / 2.0f + cell.border.bounds.size.width - 120 + (120 - frame.size.width) / 2.0f);
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
        if (!iv.isFalling) {
            iv.frame = frame;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

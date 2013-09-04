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

@interface RSViewController ()

@end

@implementation RSViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cellIdentifier = @"TMALLCell";
        
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
                if (self.isViewLoaded) {
                    [self.tableView reloadData];
                }
            });
        });
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.backgroundView.backgroundColor = kCellBackgroundColor;
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
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)didClick:(RSTMALLImageView *)imageView
{
    [super didClick:imageView];
    
    [self performSegueWithIdentifier:@"openDetail" sender:self];
}

@end

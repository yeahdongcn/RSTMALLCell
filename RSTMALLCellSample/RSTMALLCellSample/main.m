//
//  main.m
//  RSTMALLCellSample
//
//  Created by R0CKSTAR on 9/3/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSAppDelegate.h"

typedef int (*writer)(void *, const char *, int);
static writer _writer;

int __RSFilter(void *inFD, const char *buffer, int size)
{
    if (strncmp(buffer, "AssertMacros:", 13) == 0) {
        return 0;
    }
    return _writer(inFD, buffer, size);
}

int main(int argc, char * argv[])
{
    _writer = stderr->_write;
    stderr->_write = __RSFilter;
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([RSAppDelegate class]));
    }
}

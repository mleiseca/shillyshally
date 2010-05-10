//
//  SSTimeSlice.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/9/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "SSTimeSlice.h"


@implementation SSTimeSlice

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	[[NSColor magentaColor] set];
    NSRectFill(dirtyRect);
}

@end

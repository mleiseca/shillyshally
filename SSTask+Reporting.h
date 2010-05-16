//
//  SSTask+Reporting.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SSTask.h"

@interface SSTask (reporting)

- (NSNumber *) secondsWorked;
- (NSString *) timeWorked;

@end

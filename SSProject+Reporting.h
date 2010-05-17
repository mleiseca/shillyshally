//
//  SSProject+Reporting.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SSProject.h"

@interface SSProject(reporting)

- (void) awakeFromInsert;

- (NSNumber *) secondsWorked;
- (NSString *) timeWorked;
- (NSDate *) workStartDate;

@end

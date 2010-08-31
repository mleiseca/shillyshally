//
//  SSTask+Reporting.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import <Cocoa/Cocoa.h>

#import "SSTask.h"

@interface SSTask (reporting)

- (void) awakeFromInsert;
- (NSNumber *) secondsWorked;
- (NSString *) timeWorked;

@end

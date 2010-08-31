//
//  SSProject+Reporting.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import <Cocoa/Cocoa.h>

#import "SSProject.h"

@interface SSProject(reporting)

- (void) awakeFromInsert;

- (NSNumber *) secondsWorked;
- (NSString *) timeWorked;
- (NSDate *) workStartDate;
- (NSString *) descWithContext;

@end

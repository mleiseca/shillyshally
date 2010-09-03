//
//  SSFakeTask.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import <Cocoa/Cocoa.h>

#import "SSTask.h"

@interface SSFakeTask : SSTask {
	NSSet *taskSessions;
}

@property (nonatomic, retain) NSSet *taskSessions;

@end

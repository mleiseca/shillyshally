//
//  SSFakeTask.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SSTask.h"

@interface SSFakeTask : SSTask {
	NSSet *taskSessions;
}

@property (nonatomic, retain) NSSet *taskSessions;

@end

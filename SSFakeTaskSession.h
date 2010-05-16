//
//  SSFakeTaskSession.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MGLTaskSession.h"


@interface SSFakeTaskSession : MGLTaskSession {
	NSNumber *secondsWorked;
}

@property (nonatomic, retain) NSNumber * secondsWorked;


@end

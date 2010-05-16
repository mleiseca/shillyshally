//
//  SSFakeTaskSession.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SSTaskSession.h"


@interface SSFakeTaskSession : SSTaskSession {
	NSNumber *secondsWorked;
}

@property (nonatomic, retain) NSNumber * secondsWorked;


@end

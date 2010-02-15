//
//  MGLTaskProgressTimer.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MGLTask;

@interface MGLTaskProgressTimer : NSObject {
	MGLTask *activeTask;
	NSDate *startDate;
	NSTimer *timer;
	
}

@property(nonatomic, retain) MGLTask *activeTask;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) NSDate *startDate;

-(void) startTask:(MGLTask *) task;
-(void) stopTask;


@end

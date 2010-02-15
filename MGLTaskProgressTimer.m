//
//  MGLTaskProgressTimer.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTaskProgressTimer.h"
#import "MGLTask.h"
#import "MGLTaskSession.h"

@implementation MGLTaskProgressTimer
@synthesize activeTaskSession;
@synthesize timer;
@synthesize startDate;

-(void) startTaskSession:(MGLTaskSession *) taskSession{
	NSLog(@"Starting task: %@", [[taskSession task] desc]);
	
	if(activeTaskSession){
		[self stopTask];
	}
	
	self.startDate = [NSDate date];
	self.activeTaskSession = taskSession;
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(incrementTime:) userInfo: nil repeats:YES];
}

-(void) incrementTime:(id) userInfo{
	NSTimeInterval interval = [self.startDate timeIntervalSinceNow];
	NSLog(@"interval: %@, %f", self.startDate, interval); 
	self.activeTaskSession.secondsWorked = [NSNumber numberWithInteger: abs(interval)];
}

-(void) stopTask{
	NSLog(@"stopping task: %@", [[self.activeTaskSession task] desc]);
	self.activeTaskSession = nil;
	
	//todo: save changes, etc	

	[timer invalidate];
	self.timer = nil;
	
}

@end

//
//  MGLTaskProgressTimer.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTaskProgressTimer.h"
#import "MGLTask.h"

@implementation MGLTaskProgressTimer
@synthesize activeTask;
@synthesize timer;
@synthesize startDate;

-(void) startTask:(MGLTask *) task{
	NSLog(@"Starting task: %@", [task desc]);
	
	if(activeTask){
		[self stopTask];
	}
	self.startDate = [NSDate date];
	self.activeTask = task;
	self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(incrementTime:) userInfo: nil repeats:YES];
}

-(void) incrementTime:(id) userInfo{
	NSTimeInterval interval = [self.startDate timeIntervalSinceNow];
	NSLog(@"interval: %@, %f", self.startDate, interval); 
}

-(void) stopTask{
	NSLog(@"stopping task: %@", [self.activeTask desc]);
	self.activeTask = nil;
	
	//todo: save changes, etc	

	[timer invalidate];
	self.timer = nil;
	
}

@end

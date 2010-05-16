//
//  MGLTaskProgressTimer.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  .
//

#import "MGLTaskProgressTimer.h"
#import "MGLTask.h"
#import "MGLTaskSession.h"

@implementation MGLTaskProgressTimer
@synthesize activeTaskSession;
@synthesize timer;
@synthesize startDate;

-(void) startTaskSession:(MGLTaskSession *) taskSession{
	MGLTask *task = [taskSession task];
	NSLog(@"Starting task: %@", [task desc]);
	
	if(activeTaskSession){
		//we are starting a new task. This will shut down the old one
		[self stopTask];
	}
	
	task.running = YES;
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
	MGLTask *task = [self.activeTaskSession task];
	NSLog(@"stopping task: %@", [task desc]);
	
	task.running = NO;
	self.activeTaskSession = nil;
	
	//todo: save changes, etc	

	[timer invalidate];
	self.timer = nil;
	
}

-(BOOL) isRunning{
	return [self.timer isValid];
}

@end

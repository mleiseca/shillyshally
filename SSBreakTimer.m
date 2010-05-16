//
//  SSBreakTimer.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/23/10.
//  .
//

#import "SSBreakTimer.h"
#import "WorkTimerWithPersistence_AppDelegate.h"
#import "MGLTaskAppController.h"

#import "SSTask.h"
#import "SSConstants.h"

@implementation SSBreakTimer

@synthesize breakIntervalTimer;
@synthesize breakIntervalInSeconds;

- (void) startBreak{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	BOOL breaksEnabled = [defaults boolForKey:SSPrefBreakEnabled];

	if (! breaksEnabled){
		NSLog(@"Breaks are disabled. Skipping break");
		return;
	}
	
	WorkTimerWithPersistence_AppDelegate *appDelegate = [NSApp delegate];
	SSTask *currentTask = [appDelegate.appController taskInProgress];
	
	NSLog(@"currentTask meeting? %@" ,[currentTask meeting]);
	if ( currentTask &&  [[currentTask meeting] boolValue] ){
		NSLog(@"Skipping break because task is away");
	}else{
		[appDelegate startBreak: self]; 
	}
}

- (id) initWithBreakIntervalInMinutes: (NSNumber *) interval{
	if (![super init]){
		return nil;
	}
	
	self.breakIntervalInSeconds = [NSNumber numberWithDouble:(60 * [interval doubleValue])];
	//self.breakIntervalInSeconds = [NSNumber numberWithInteger:5];
	NSLog(@"breakinterval: %@" , self.breakIntervalInSeconds);
	
	self.breakIntervalTimer = [NSTimer scheduledTimerWithTimeInterval:[self.breakIntervalInSeconds intValue]
															   target:self 
															 selector:@selector(startBreak) 
															 userInfo:nil 
															  repeats:YES];
	
	return self;
		  
}

-(void)dealloc{
	[breakIntervalInSeconds release];
	[breakIntervalTimer invalidate];
	[breakIntervalTimer release];
	
	
	[super dealloc];
}

@end

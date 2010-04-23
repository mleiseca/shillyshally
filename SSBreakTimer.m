//
//  SSBreakTimer.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/23/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "SSBreakTimer.h"


@implementation SSBreakTimer

@synthesize breakIntervalTimer;
@synthesize breakIntervalInSeconds;

- (void) startBreak{
	[[NSApp delegate] startBreak: self]; 
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

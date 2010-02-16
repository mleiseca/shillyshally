// 
//  MGLTask.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/15/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTask.h"
#import "MGLTaskSession.h"


@implementation MGLTask 

@dynamic hoursEstimate;
@dynamic completedDate;
@dynamic ticketId;
@dynamic createDate;
@dynamic desc;
@dynamic taskSessions;
//@dynamic workStartDate;
//@dynamic secondsWorked;


- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

- (NSDate *) workStartDate{
	return [NSDate date];
}

- (NSNumber *) secondsWorked{
	MGLTaskSession *taskSession = nil;
	long secondsWorked = 0l;
	
	for(taskSession in self.taskSessions){
		secondsWorked = secondsWorked + [taskSession.secondsWorked longValue];
	}
	return [NSNumber numberWithLong:secondsWorked];
}

- (NSString *) timeWorked{
	NSNumber *secondsWorked = [self secondsWorked];
	
	if(secondsWorked){
		int seconds = [secondsWorked intValue];
		int minutesWorked =  seconds / 60;
		
		return [NSString stringWithFormat:@"%d:%02d", (minutesWorked/60), (minutesWorked % 60)];
    }else{
	   return @"";
    }
}


@end

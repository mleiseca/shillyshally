// 
//  MGLTask.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTask.h"

#import "MGLProject.h"
#import "MGLTaskSession.h"

@implementation MGLTask 

@dynamic completedDate;
@dynamic createDate;
@dynamic ticketId;
@dynamic meeting;
@dynamic desc;
@dynamic note;
@dynamic hoursEstimate;
@dynamic taskSessions;
@dynamic project;


- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

- (NSDate *) workStartDate{
	MGLTaskSession *taskSession = nil;
	NSDate *earliestStart = nil;
	
	for(taskSession in self.taskSessions){
		if(earliestStart == nil){
			earliestStart = taskSession.createDate;
		} else{
			earliestStart = [earliestStart earlierDate:taskSession.createDate];
		}
	}
	return earliestStart;
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

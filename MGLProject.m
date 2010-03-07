// 
//  MGLProject.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/28/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLProject.h"

#import "MGLTask.h"

@implementation MGLProject 

@dynamic createDate;
@dynamic active;
@dynamic desc;
@dynamic tasks;


- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

- (NSNumber *) secondsWorked{
	MGLTask *task = nil;
	long secondsWorked = 0l;
	
	for(task in self.tasks){
		secondsWorked = secondsWorked + [task.secondsWorked longValue];
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

- (NSDate *) workStartDate{
	MGLTask *task = nil;
	NSDate *earliestStart = nil;
	
	for(task in self.tasks){
		if(earliestStart == nil){
			earliestStart = [task workStartDate];
		} else{
			earliestStart = [earliestStart earlierDate:[task workStartDate]];
		}
	}
	return earliestStart;
}

@end

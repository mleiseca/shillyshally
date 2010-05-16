//
//  SSTask+Reporting.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "SSTask+Reporting.h"
#import "SSTaskSession.h"

@implementation SSTask (reporting)

- (NSNumber *) secondsWorked{
	return [self valueForKeyPath:@"taskSessions.@sum.secondsWorked"];
}

- (NSString *) timeWorked{
	NSNumber *secondsWorked = [self secondsWorked];
	if(secondsWorked){
		int seconds = [secondsWorked intValue];
		int minutesWorked =  seconds / 60;
		
		return [NSString stringWithFormat:@"%d:%02d", (minutesWorked/60), (minutesWorked % 60) ];
    }else{
		return @"";
    }
}

- (NSDate *) workStartDate{
	SSTaskSession *taskSession = nil;
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



@end

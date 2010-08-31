//
//  SSTask+Reporting.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import "SSTask+Reporting.h"
#import "SSTaskSession.h"

@implementation SSTask (reporting)


- (void) awakeFromInsert{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

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

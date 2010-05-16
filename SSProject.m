// 
//  MGLProject.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/28/10.
//  .
//

#import "SSProject.h"

#import "SSTask.h"

@implementation SSProject 

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
	return [self valueForKeyPath:@"tasks.@sum.secondsWorked"];
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
	SSTask *task = nil;
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
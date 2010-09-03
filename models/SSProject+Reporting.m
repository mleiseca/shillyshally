//
//  SSProject+Reporting.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import "SSProject+Reporting.h"

#import "SSProject.h"

@implementation SSProject(reporting)

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

- (NSString *) descWithContext{
	if (self.parentProject){
		return [NSString stringWithFormat:@"%@ > %@", [self.parentProject descWithContext], self.desc];
		
	}else{
		return self.desc;
	}
	
}

@end

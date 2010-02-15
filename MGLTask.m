// 
//  MGLTask.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTask.h"


@implementation MGLTask 

@dynamic hoursEstimate;
@dynamic completedDate;
@dynamic workStartDate;
@dynamic ticketId;
@dynamic createDate;
@dynamic desc;
@dynamic secondsWorked;



- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}


@end

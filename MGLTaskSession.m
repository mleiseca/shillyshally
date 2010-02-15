// 
//  MGLTaskSession.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/15/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTaskSession.h"

#import "MGLTask.h"

@implementation MGLTaskSession 

@dynamic createDate;
@dynamic secondsWorked;
@dynamic task;

- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

@end

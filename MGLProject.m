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

@end

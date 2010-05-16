// 
//  MGLTask.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  .
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

@synthesize running;


- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

@end

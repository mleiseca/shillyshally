// 
//  MGLTask.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  .
//

#import "SSTask.h"

#import "SSProject.h"
#import "SSTaskSession.h"

@implementation SSTask 

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


- (void) awakeFromInsert{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

@end

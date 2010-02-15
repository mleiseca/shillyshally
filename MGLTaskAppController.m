//
//  MGLTaskAppController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTaskAppController.h"
#import "MGLTaskProgressTimer.h"
#import "MGLTask.h"
#import "MGLTaskSession.h"
#import "WorkTimerWithPersistence_AppDelegate.h"

@implementation MGLTaskAppController

@synthesize taskList;
@synthesize taskProgressTimer;
@synthesize appDelegate;

-(IBAction) startSelectedTask:(id) sender{
	NSLog(@"Starting selected task");
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		MGLTask *selectedTask = [selectedTasks objectAtIndex:0];
		
		MGLTaskSession *taskSession = [NSEntityDescription
								 insertNewObjectForEntityForName:@"MGLTaskSession" inManagedObjectContext:self.appDelegate.managedObjectContext];
		
		taskSession.task = selectedTask;
		
		[self.taskProgressTimer startTaskSession:taskSession];
	}
}

@end

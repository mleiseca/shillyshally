//
//  MGLTaskAppController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTaskAppController.h"
#import "MGLTaskProgressTimer.h"

@implementation MGLTaskAppController

@synthesize taskList;
@synthesize taskProgressTimer;

-(IBAction) startSelectedTask:(id) sender{
	NSLog(@"Starting selected task");
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		MGLTask *selectedTask = [selectedTasks objectAtIndex:0];
		[self.taskProgressTimer startTask:selectedTask];
	}
}

@end

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
@synthesize activeTaskLabel;
@synthesize toggleTaskToolbarItem;
@synthesize taskTableView;

- (void) startTask: (MGLTask *) selectedTask  {
	//either 
	MGLTaskSession *taskSession = [NSEntityDescription
								   insertNewObjectForEntityForName:@"MGLTaskSession" inManagedObjectContext:self.appDelegate.managedObjectContext];

	taskSession.task = selectedTask;

	[self.toggleTaskToolbarItem setPaletteLabel:@"Stop"];

	[self.activeTaskLabel setStringValue:[NSString stringWithFormat:@"%@", selectedTask.desc]];
	[self.taskProgressTimer startTaskSession:taskSession];
}

-(void) stopTask{
	[self.toggleTaskToolbarItem setPaletteLabel:@"Start"];

	[self.activeTaskLabel setStringValue:@""];
	
	[self.taskProgressTimer stopTask];
	
}

-(IBAction) toggleSelectedTask:(id) sender{
	NSLog(@"Toggling selected task");
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		
		MGLTask *selectedTask = [selectedTasks objectAtIndex:0];
		
		if(self.taskProgressTimer.activeTaskSession.task == selectedTask){
			if(self.taskProgressTimer.isRunning){
				// current task is running. should be stopped.
				NSLog(@"Selected task is running");
				[self stopTask];
				
			}else{
				// current task is not running. Was stopped maybe? start it up.
				//NSLog(@"Selected task is in taskProgressTimer but NOT running");
				//[self startTask: selectedTask];
			}
		}else {
			NSLog(@"Selected task is NOT running");
			
			if(self.taskProgressTimer.isRunning){
				[self stopTask];
			}else{
				[self startTask: selectedTask];
			}			
		}
	}
}

-(IBAction) finishTask:(id) sender{
	NSLog(@"finished"); 
	
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		MGLTask *selectedTask = [selectedTasks objectAtIndex:0];

		NSLog(@"finishing task: %@", [selectedTask desc]);
		selectedTask.completedDate = [NSDate date];
		
		NSLog(@"Processing pending changes");
		[appDelegate.managedObjectContext processPendingChanges] ;
		
		[taskList rearrangeObjects];
	}
	
}


@end

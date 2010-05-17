//
//  MGLTaskAppController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  .
//

#import "SSWindowController.h"
#import "MGLTaskProgressTimer.h"
#import "SSTask.h"
#import "SSTaskSession.h"
#import "WorkTimerWithPersistence_AppDelegate.h"
#import "MGLProjectsController.h"
#import "SSReportsController.h"

@implementation SSWindowController

@synthesize taskList;
@synthesize projectList;
@synthesize taskProgressTimer;
@synthesize appDelegate;
@synthesize taskToggleToolbarItem;
@synthesize taskTableView;
@synthesize taskDoneToolbarItem;

@synthesize projectsController;
@synthesize reportController;


- (void) startTask: (SSTask *) selectedTask  {
	//either 
	SSTaskSession *taskSession = [NSEntityDescription
								   insertNewObjectForEntityForName:@"SSTaskSession" inManagedObjectContext:self.appDelegate.managedObjectContext];

	taskSession.task = selectedTask;

	[self.taskToggleToolbarItem setPaletteLabel:@"Pause"];
	[self.taskToggleToolbarItem setLabel:@"Pause"];
	[self.taskToggleToolbarItem setImage:[NSImage imageNamed:@"Pause.tiff"]];
	
	[self.taskProgressTimer startTaskSession:taskSession];
	
	NSImage *newIconImage = [NSImage imageNamed: @"TheBendsActive"];
	[NSApp setApplicationIconImage: newIconImage];
}

-(void) stopTask{
	[self.taskToggleToolbarItem setPaletteLabel:@"Start"];
	[self.taskToggleToolbarItem setLabel:@"Start"];
	[self.taskToggleToolbarItem setImage:[NSImage imageNamed:@"Play.tiff"]];

	[NSApp setApplicationIconImage: nil];
	
	[self.taskProgressTimer stopTask];	
}

-(IBAction) toggleSelectedTask:(id) sender{
	NSLog(@"Toggling selected task");
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		
		SSTask *selectedTask = [selectedTasks objectAtIndex:0];
		
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

-(void) changeSelectedProjectWithIndex: (NSInteger) change{
	NSArray *projects = [projectList arrangedObjects];
	
	if(projects == nil || [projects count] ==0){
		//no project entered. No use in continuing
		
		return;
	}
	
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		SSTask *selectedTask = [selectedTasks objectAtIndex:0];
		
		NSInteger currentIndex = [projects indexOfObject: selectedTask.project];
		
		if(currentIndex == NSNotFound){
			
			if(change > 0){
				selectedTask.project = [projects objectAtIndex:0];
			}else{
				selectedTask.project = [projects objectAtIndex:[projects count]-1];				
			}
			
		}else{
			
			//make sure that index is within valid range.
			NSInteger newIndex = change + currentIndex;
			NSInteger projectCount = [projects count];
			
			NSLog(@"new index: %d, project count %d", newIndex, projectCount );
			if(0 <= newIndex &&   newIndex < projectCount ){
				selectedTask.project = [projects objectAtIndex:newIndex];
				NSLog(@"Switching projects");
			}else{
				NSLog(@"NOT Switching projects");
			}
		}
	}
}

-(IBAction) changeSelectedTaskProjectUp{
	[self changeSelectedProjectWithIndex:-1];
}

-(IBAction) changeSelectedTaskProjectDown{
	[self changeSelectedProjectWithIndex:1];
}


-(IBAction) finishTask:(id) sender{
	NSLog(@"finished"); 
	
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		SSTask *selectedTask = [selectedTasks objectAtIndex:0];
		
		[[[appDelegate applicationUndoManager]  prepareWithInvocationTarget:self.taskList] rearrangeObjects];

		if(self.taskProgressTimer.activeTaskSession.task == selectedTask){
			NSLog(@"...done with currently running task");
			[self stopTask];
		}
		
		NSLog(@"finishing task: %@", [selectedTask desc]);
		[selectedTask setCompletedDate:[NSDate date]];
		
		NSLog(@"Processing pending changes");
		[appDelegate.managedObjectContext processPendingChanges] ;
		
		
		[taskList rearrangeObjects];
	}
	
}


-(void) copyCurrentTableRow{
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		SSTask *selectedTask = [selectedTasks objectAtIndex:0];

		NSString *ticketReference= @"";
		
		id ticketId = [selectedTask ticketId];
		if(ticketId){
			ticketReference = [NSString stringWithFormat:@"refs #%@", ticketId];
		}

		NSString *message = [NSString stringWithFormat:@"%@: %@ %@", [[selectedTask project] desc], [selectedTask desc], ticketReference];
		
		NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
		[pasteboard clearContents];
		NSArray *objectsToCopy = [NSArray arrayWithObject:message];
		[pasteboard writeObjects:objectsToCopy];
		
	}	
}


-(SSTask *) taskInProgress{
	return [[taskProgressTimer activeTaskSession] task];	
}


- (void)copy:(id)sender;
{
	//	http://www.omnigroup.com/mailman/archive/macosx-dev/2001-June/028436.html
	//NSLog(@"Copy: WorkTimerWithPersistence_AppDelegate");
	//	NSResponder *firstResponder;
	
	//	firstResponder = [[self window] firstResponder];
	
	[self copyCurrentTableRow];
	
}

-(IBAction) openProjectsWindow:(id) sender{
	if (! projectsController){
		self.projectsController = [[MGLProjectsController alloc] init];
	}
	[self.projectsController showProjectsWindow:sender];
}

-(IBAction) openReportingWindw:(id) sender{
	if(! reportController){
		self.reportController = [[SSReportsController alloc] init];
	}
	
	[self.reportController showReportsWindow:sender];
}

- (void) dealloc{
	[reportController release];
	[projectsController release];

	[super dealloc];
}



@end

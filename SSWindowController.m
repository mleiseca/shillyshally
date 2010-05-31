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
#import "MGLArrayController_CompletedTaskFilter.h"
#import "MGLProjectsController.h"
#import "SSReportsWindowController.h"

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

@synthesize treeController;
@synthesize outlineView;

- (void) dealloc{
	[reportController release];
	[projectsController release];
	[treeController release];
	[outlineView release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark Task Management

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

-(void) createTask{
	[taskList insert:self];
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
		self.reportController = [[SSReportsWindowController alloc] init];
	}
	
	[self.reportController showReportsWindow:sender];
}

- (void)keyDown:(NSEvent *)theEvent{
	short keyCode = [theEvent keyCode];
	NSLog(@"keyDown: %d", keyCode );
	
	unsigned flags = [theEvent modifierFlags];
	
    BOOL isShiftPressed = (flags & NSShiftKeyMask)  == NSShiftKeyMask ;
	BOOL isCommandPressed = (flags & NSCommandKeyMask)  == NSCommandKeyMask;
	
	if(isShiftPressed || isCommandPressed){
		if (isShiftPressed && isCommandPressed){
			if(keyCode == 40){
				//command shift k = start/stop				
				[self toggleSelectedTask:self];
				return;
			}else if(keyCode == 14){
				//command shift e = done 
				[self finishTask:self];
				return;
			}else if (keyCode == 45){
				[self createTask];
				return;
			}
		}
	}
	
	[super keyDown:theEvent];

}



#pragma mark -
#pragma mark Project Outline view drag/drop
/*
 Up to this point, the code in this file is generated when you select an Xcode project 
 of type Cocoa Core Data Application. The methods below are implemented to support 
 drag and drop. For general information on drag and drop in Cocoa, go to 
 http://developer.apple.com/documentation/Cocoa/Conceptual/DragandDrop/DragandDrop.html
 Outline views have their own API for drag and drop within the NSOutlineViewDataSource
 informal protocol. Reference for that protocol can be found at
 http://developer.apple.com/documentation/Cocoa/Reference/ApplicationKit/Protocols/NSOutlineViewDataSource_Protocol/Reference/Reference.html
 */

// Declare a string constant for the drag type - to be used when writing and retrieving pasteboard data...
NSString *AbstractTreeNodeType = @"AbstractTreeNodeType";

/*
 Run time setup.
 */
- (void)awakeFromNib {
    // Set the outline view to accept the custom drag type AbstractTreeNodeType...
    [outlineView registerForDraggedTypes:[NSArray arrayWithObject:AbstractTreeNodeType]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(outlineViewSelectionDidChange:) 
												 name:NSOutlineViewSelectionDidChangeNotification object:outlineView];
}

/*
 Beginning the drag from the outline view.
 */
- (BOOL)outlineView:(NSOutlineView *)outlineView writeItems:(NSArray *)items toPasteboard:(NSPasteboard *)pboard {
	//NSLog(@"write");
    // Tell the pasteboard what kind of data we'll be placing on it
    [pboard declareTypes:[NSArray arrayWithObject:AbstractTreeNodeType] owner:self];
    // Query the NSTreeNode (not the underlying Core Data object) for its index path under the tree controller.
    NSIndexPath *pathToDraggedNode = [[items objectAtIndex:0] indexPath];
    // Place the index path on the pasteboard.
    NSData *indexPathData = [NSKeyedArchiver archivedDataWithRootObject:pathToDraggedNode];
    [pboard setData:indexPathData forType:AbstractTreeNodeType];
    // Return YES so that the drag actually begins...
    return YES;
}

/*
 Performing a drop in the outline view. This allows the user to manipulate the structure of the tree by moving subtrees under new parent nodes.
 */
- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id <NSDraggingInfo>)info item:(id)item childIndex:(NSInteger)index {
	//NSLog(@"accept");

    // Retrieve the index path from the pasteboard.
    NSIndexPath *droppedIndexPath = [NSKeyedUnarchiver unarchiveObjectWithData:[[info draggingPasteboard] dataForType:AbstractTreeNodeType]];
    // We need to find the NSTreeNode positioned at the index path. We start by getting the root node of the tree.
    // In NSTreeController, arrangedObjects returns the root node of the tree.
	id treeRoot = [treeController arrangedObjects];
	 // Find the node being moved by querying the root node. NSTreeNode is a 10.5 API.
	 NSTreeNode *node = [treeRoot descendantNodeAtIndexPath:droppedIndexPath];
	 // Use the tree controller to move the node. This will manage any changes necessary in the parent-child relationship.
	 // modeNode:toIndex:Path is a 10.5 API addition to NSTreeController.
	 [treeController moveNode:node toIndexPath:[[item indexPath] indexPathByAddingIndex:0]];
	 // Return YES so that the user gets visual feedback that the drag was successful...
	return YES;
}

/*
 Validating a drop in the outline view. This method is called to determine whether or not to permit a drop operation. There are two cases in which this application will not permit a drop to occur:
 • A node cannot be dropped onto one of its descendents
 • A node cannot be dropped "between" two other nodes. That would imply some kind of ordering, which is not provided for in the data model.
 */
- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id <NSDraggingInfo>)info proposedItem:(id)item proposedChildIndex:(NSInteger)index {
	//NSLog(@"validate");

    // The index indicates whether the drop would take place directly on an item or between two items. 
    // Between items implies that sibling ordering is supported (it's not in this application),
    // so we only indicate a valid operation if the drop is directly over (index == -1) an item.
    if (index != -1) {
        return NSDragOperationNone;
    }
    
    // Retrieve the index path from the pasteboard.
    NSIndexPath *droppedIndexPath = [NSKeyedUnarchiver unarchiveObjectWithData:[[info draggingPasteboard] dataForType:AbstractTreeNodeType]];
    // We need to find the NSTreeNode positioned at the index path. We start by getting the root node of the tree.
    // In NSTreeController, arrangedObjects returns the root node of the tree.
	 id treeRoot = [treeController arrangedObjects];
	 // Find the node being moved by querying the root node. NSTreeNode is a 10.5 API.
	 NSTreeNode *node = [treeRoot descendantNodeAtIndexPath:droppedIndexPath];
	 NSTreeNode *parent = item;
	 while (parent != nil) {
	 if (parent == node) {
		 return NSDragOperationNone;
	 }
		 parent = [parent parentNode];
	 }
	    
    // All tests have been passed; permit the drop by returning a valid drag operation.
    return NSDragOperationGeneric;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification{
	NSArray *selectedObjects = [treeController selectedObjects];
	if (selectedObjects && ([selectedObjects count] > 0)){
		taskList.currentProject = [selectedObjects objectAtIndex:0];
	}else{
		taskList.currentProject = nil;
	}
	
	[taskList rearrangeObjects];
	
}


- (NSArray *) createProjectSortDescriptors{
	
	NSSortDescriptor *sort = [[[NSSortDescriptor alloc]
						   initWithKey:@"descWithContext"
						   ascending:YES
						   selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];

	return [NSArray arrayWithObject:sort];
	
}






@end

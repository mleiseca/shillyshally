//
//  MGLTaskAppController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  .
//

#import "SSWindowController.h"
#import "SSConstants.h"
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

@synthesize currentlySelectedProject;

@synthesize starredActiveTaskController;

- (void) dealloc{
	SS_RELEASE_SAFELY(reportController);
	SS_RELEASE_SAFELY(projectsController);
	SS_RELEASE_SAFELY(treeController);
    SS_RELEASE_SAFELY(outlineView);
    
    
    [starredActiveTaskController removeObserver:self forKeyPath:@"selectionIndexes"];

    SS_RELEASE_SAFELY(starredActiveTaskController);
	SS_RELEASE_SAFELY(currentlySelectedProject);
    
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
    	
	NSManagedObjectContext *context  = [[NSApp delegate] managedObjectContext];

	
	SSTask *task = [NSEntityDescription
								  insertNewObjectForEntityForName:@"SSTask" inManagedObjectContext:context];

    task.project = self.currentlySelectedProject;
	
	[taskList addObject:task];
}

-(void)openTicketForCurrentTask:(id)sender{
	NSArray *selectedTasks = [self.taskList selectedObjects] ;
	if([selectedTasks count] == 1){
		
		SSTask *selectedTask = [selectedTasks objectAtIndex:0];
		
		if (selectedTask.ticketId){
			
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			NSString *ticketSystemBaseUrl = [defaults stringForKey:SSPrefTicketSystemBaseURL];

			if (ticketSystemBaseUrl){			
				NSString *urlString = [NSString stringWithFormat:@"%@%@", ticketSystemBaseUrl, selectedTask.ticketId];
				[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]];
			}

		}
	}		
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
		
		NSUndoManager *undoManager = [appDelegate applicationUndoManager];
		[[undoManager  prepareWithInvocationTarget:self.taskList] rearrangeObjects];

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

#pragma mark -
#pragma mark firstResponder methods

-(void) newTask:(id)sender{
	[self createTask];	
}

-(void) undo:(id)sender{
	
	NSLog(@"trying to undo");
}

-(void) redo:(id)sender{
	
	NSLog(@"trying to redo");
}


-(void) save:(id)sender{
    //we are keeping the firstResponder around in order to flush changes from the current text field
    // and then resume the operation that the user was in the middle of.
    // Doing this will prevent loss of the data the user just typed and not interrupt the user's work flow
    
    id firstResponder = [[self window] firstResponder];
    [[self window] makeFirstResponder:nil];
    
	NSLog(@"trying to save");
	NSError *error = nil;
	[self.appDelegate.managedObjectContext save:&error];

    
    //restore first responder to continue user's workflow
    [[self window] makeFirstResponder:firstResponder];

}

- (void)copy:(id)sender;
{
	[self copyCurrentTableRow];	
}

-(IBAction) openProjectsWindow:(id) sender{
	if (! projectsController){
		self.projectsController = [[MGLProjectsController alloc] init];
	}
	[self.projectsController showProjectsWindow:sender];
}

-(IBAction) openReportingWindow:(id) sender{
	if(! reportController){
		self.reportController = [[SSReportsWindowController alloc] init];
	}
	
	[self.reportController showReportsWindow:sender];
}

/*
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
			}
		}else if (isCommandPressed){
			if (keyCode == 45){
				//command n = create task
				[self createTask];
				return;
			}
		}
	}
	
	NSLog(@"keyDown: using default");
	
	[super keyDown:theEvent];

}
 
 */



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
    
    
    //watch for change in selection for starredActiveTasks
    // http://www.pietrop.com/wordpress/dev-area/tutorials/manage-nscollectionview-and-nsarraycontroller-selection-using-observers/
    
    [starredActiveTaskController addObserver:self forKeyPath:@"selectionIndexes" options:NSKeyValueObservingOptionNew context:nil];

    
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

-(void)updateProjectSelection:(NSArray*)selectedObjects{
    
    SSProject *project = nil;
    if ([selectedObjects count] > 0){
        project = [selectedObjects objectAtIndex:0];
	}

    taskList.currentProject = project;
    self.currentlySelectedProject = project;
	
	[taskList rearrangeObjects];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification{
	NSArray *selectedObjects = [treeController selectedObjects];
	[self updateProjectSelection:selectedObjects];
}


- (NSArray *) createProjectSortDescriptors{
	
	NSSortDescriptor *sort = [[[NSSortDescriptor alloc]
						   initWithKey:@"descWithContext"
						   ascending:YES
						   selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];

	return [NSArray arrayWithObject:sort];
	
}

#pragma mark -
#pragma mark Starred project subview support

//Observer for the collection view array controller selection: "selectionIndexes"
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == starredActiveTaskController && [keyPath isEqualTo:@"selectionIndexes"])
    {
        [self updateProjectSelection:[starredActiveTaskController selectedObjects]];
    }
}

#pragma mark -
#pragma mark NSWindowDelegate
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [self.appDelegate.managedObjectContext undoManager];
}






@end

//
//  MGLTaskAppController.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class MGLTaskProgressTimer;
@class WorkTimerWithPersistence_AppDelegate;
@class MGLArrayController_CompletedTaskFilter;
@class SSTask;
@class MGLProjectsController;
@class SSReportsWindowController;
@class SSProject;

@interface SSWindowController : NSWindowController<NSWindowDelegate> {
	WorkTimerWithPersistence_AppDelegate	*appDelegate;
	MGLArrayController_CompletedTaskFilter	*taskList;
	NSArrayController	*projectList;
	
	MGLTaskProgressTimer *taskProgressTimer;
	
	NSToolbarItem	*taskToggleToolbarItem;
	NSToolbarItem	*taskDoneToolbarItem;
	NSMenuItem		*toggleMenuItem;
	
	NSTableView	*taskTableView;
	MGLProjectsController *projectsController;
	SSReportsWindowController  *reportController;
	
	NSOutlineView *outlineView;
	NSTreeController *treeController;
    
    NSArrayController *starredActiveTaskController;
    
    
    //this might be selected by either the tree or list on the screen left
    //keeping it around so we know which project to use when creating a 
    // new task
    SSProject *currentlySelectedProject;
	
}

@property(nonatomic, retain) WorkTimerWithPersistence_AppDelegate	 *appDelegate;

@property(nonatomic, retain) IBOutlet MGLArrayController_CompletedTaskFilter *taskList;
@property(nonatomic, retain) IBOutlet NSArrayController  *projectList;


@property(nonatomic, retain) IBOutlet MGLTaskProgressTimer	*taskProgressTimer;

@property(nonatomic, retain) IBOutlet NSToolbarItem	*taskToggleToolbarItem;
@property(nonatomic, retain) IBOutlet NSToolbarItem	*taskDoneToolbarItem;
@property(nonatomic, retain) IBOutlet NSTableView	*taskTableView;


@property (nonatomic, retain) MGLProjectsController *projectsController;
@property (nonatomic, retain) SSReportsWindowController  *reportController;

@property (nonatomic, retain) IBOutlet NSOutlineView *outlineView;
@property (nonatomic, retain) IBOutlet NSTreeController *treeController;

@property (nonatomic, retain) IBOutlet NSArrayController *starredActiveTaskController;

@property (nonatomic, retain) SSProject *currentlySelectedProject;


-(void)openTicketForCurrentTask:(id)sender;
-(IBAction) toggleSelectedTask:(id) sender;
-(IBAction) finishTask:(id) sender;
-(void) stopTask;
-(void) createTask;


-(IBAction) changeSelectedTaskProjectUp;
-(IBAction) changeSelectedTaskProjectDown;
	
-(void) copyCurrentTableRow;

-(SSTask *) taskInProgress;

-(IBAction) openProjectsWindow:(id) sender;
-(IBAction) openReportingWindow:(id) sender;

//todo: move? monitoring for changes in project selection
- (void)outlineViewSelectionDidChange:(NSNotification *)notification;

- (NSArray *) createProjectSortDescriptors;

@end

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
@class SSReportsController;

@interface SSWindowController : NSWindowController {
	WorkTimerWithPersistence_AppDelegate	*appDelegate;
	MGLArrayController_CompletedTaskFilter	*taskList;
	NSArrayController	*projectList;
	
	MGLTaskProgressTimer *taskProgressTimer;
	
	NSToolbarItem	*taskToggleToolbarItem;
	NSToolbarItem	*taskDoneToolbarItem;
	NSMenuItem		*toggleMenuItem;
	
	NSTableView	*taskTableView;
	MGLProjectsController *projectsController;
	SSReportsController  *reportController;
	
	NSOutlineView *outlineView;
	NSTreeController *treeController;
	
}

@property(nonatomic, retain) WorkTimerWithPersistence_AppDelegate	 *appDelegate;

@property(nonatomic, retain) IBOutlet MGLArrayController_CompletedTaskFilter *taskList;
@property(nonatomic, retain) IBOutlet NSArrayController  *projectList;


@property(nonatomic, retain) IBOutlet MGLTaskProgressTimer	*taskProgressTimer;

@property(nonatomic, retain) IBOutlet NSToolbarItem	*taskToggleToolbarItem;
@property(nonatomic, retain) IBOutlet NSToolbarItem	*taskDoneToolbarItem;
@property(nonatomic, retain) IBOutlet NSTableView	*taskTableView;


@property (nonatomic, retain) MGLProjectsController *projectsController;
@property (nonatomic, retain) SSReportsController  *reportController;

@property (nonatomic, retain) IBOutlet NSOutlineView *outlineView;
@property (nonatomic, retain) IBOutlet NSTreeController *treeController;

-(IBAction) toggleSelectedTask:(id) sender;
-(IBAction) finishTask:(id) sender;
-(void) stopTask;


-(IBAction) changeSelectedTaskProjectUp;
-(IBAction) changeSelectedTaskProjectDown;
	
-(void) copyCurrentTableRow;

-(SSTask *) taskInProgress;

-(IBAction) openProjectsWindow:(id) sender;
-(IBAction) openReportingWindw:(id) sender;

-(IBAction) add: (id) sender;
-(IBAction) addChild: (id) sender;
-(IBAction) insert: (id) sender;
-(IBAction) insertChild: (id) sender;

@end

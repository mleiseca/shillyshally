//
//  MGLTaskAppController.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MGLTaskProgressTimer;
@class WorkTimerWithPersistence_AppDelegate;
@class MGLArrayController_CompletedTaskFilter;

@interface MGLTaskAppController : NSObject {
	MGLArrayController_CompletedTaskFilter	*taskList;
	WorkTimerWithPersistence_AppDelegate	*appDelegate;

	MGLTaskProgressTimer *taskProgressTimer;
	
	NSTextField		*activeTaskLabel;
	NSToolbarItem	*taskToggleToolbarItem;
	NSToolbarItem	*taskDoneToolbarItem;
	NSMenuItem		*toggleMenuItem;
}

@property(nonatomic, retain) IBOutlet MGLArrayController_CompletedTaskFilter *taskList;
@property(nonatomic, retain) IBOutlet WorkTimerWithPersistence_AppDelegate	 *appDelegate;

@property(nonatomic, retain) IBOutlet MGLTaskProgressTimer	*taskProgressTimer;

@property(nonatomic, retain) IBOutlet NSTextField	*activeTaskLabel;
@property(nonatomic, retain) IBOutlet NSToolbarItem	*taskToggleToolbarItem;
@property(nonatomic, retain) IBOutlet NSToolbarItem	*taskDoneToolbarItem;
@property(nonatomic, retain) IBOutlet NSTableView	*taskTableView;



-(IBAction) toggleSelectedTask:(id) sender;
-(IBAction) finishTask:(id) sender;
-(void) copyCurrentTableRow;

@end

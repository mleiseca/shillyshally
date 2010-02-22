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
	MGLArrayController_CompletedTaskFilter *taskList;
	MGLTaskProgressTimer *taskProgressTimer;
	WorkTimerWithPersistence_AppDelegate *appDelegate;
	NSTextField *activeTaskLabel;
	NSButton    *toggleTaskButton;
	NSMenuItem  *toggleMenuItem;
	NSTableView *taskTableView;
}

@property(nonatomic, retain) IBOutlet MGLArrayController_CompletedTaskFilter *taskList;
@property(nonatomic, retain) IBOutlet MGLTaskProgressTimer *taskProgressTimer;
@property(nonatomic, retain) IBOutlet WorkTimerWithPersistence_AppDelegate *appDelegate;
@property(nonatomic, retain) IBOutlet NSTextField *activeTaskLabel;
@property(nonatomic, retain) IBOutlet NSButton *toggleTaskButton;
@property(nonatomic, retain) IBOutlet NSTableView *taskTableView;



-(IBAction) toggleSelectedTask:(id) sender;
-(IBAction) finishTask:(id) sender;

@end

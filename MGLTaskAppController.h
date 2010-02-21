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

@interface MGLTaskAppController : NSObject {
	NSArrayController *taskList;
	MGLTaskProgressTimer *taskProgressTimer;
	WorkTimerWithPersistence_AppDelegate *appDelegate;
	NSTextField *activeTaskLabel;
	NSButton    *toggleTaskButton;
}

@property(nonatomic, retain) IBOutlet NSArrayController *taskList;
@property(nonatomic, retain) IBOutlet MGLTaskProgressTimer *taskProgressTimer;
@property(nonatomic, retain) IBOutlet WorkTimerWithPersistence_AppDelegate *appDelegate;
@property(nonatomic, retain) IBOutlet NSTextField *activeTaskLabel;
@property(nonatomic, retain) IBOutlet NSButton *toggleTaskButton;



-(IBAction) toggleSelectedTask:(id) sender;

@end

//
//  MGLTaskAppController.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MGLTaskProgressTimer;

@interface MGLTaskAppController : NSObject {
	NSArrayController *taskList;
	MGLTaskProgressTimer *taskProgressTimer;
}

@property(nonatomic, retain) IBOutlet NSArrayController *taskList;
@property(nonatomic, retain) IBOutlet MGLTaskProgressTimer *taskProgressTimer;

-(IBAction) startSelectedTask:(id) sender;

@end

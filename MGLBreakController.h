//
//  MGLBreakController.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/11/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class MGLTaskAppController;

@interface MGLBreakController : NSObject {
	NSWindow *breakWindow;
	NSTextField *countdownLabel;
	NSButton *stillAroundButton;
	
	int secondsRemainingInBreak;
	
	NSTimer *breakTimer;
	NSTimer *stopTaskTimer;
	
	MGLTaskAppController *appController;
	
}

@property (nonatomic, retain) IBOutlet NSWindow    *breakWindow;
@property (nonatomic, retain) IBOutlet NSTextField *countdownLabel;
@property (nonatomic, retain) IBOutlet NSButton *stillAroundButton;

@property (nonatomic, retain) MGLTaskAppController *appController;
@property (nonatomic, retain) NSTimer *breakTimer;
@property (nonatomic, retain) NSTimer *stopTaskTimer;

-(void) showBreakWindow:(id) sender;

-(IBAction) stillAroundConfirmation:(id) sender;

- (id) initWithAppController: (MGLTaskAppController *) appController;


@end

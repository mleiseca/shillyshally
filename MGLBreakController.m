//
//  MGLBreakController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/11/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLBreakController.h"
#import "MGLTaskAppController.h"

@implementation MGLBreakController

@synthesize breakWindow;
@synthesize countdownLabel;
@synthesize breakTimer;
@synthesize stopTaskTimer;
@synthesize stillAroundButton;
@synthesize appController;


- (id) initWithAppController: (MGLTaskAppController *) appControllerArg{
	if(![super init]){
		return nil;
	}
	
	self.appController = appControllerArg;
	
	return self;
}

-(void) incrementBreakTime:(id) userInfo{
		//	NSTimeInterval interval = [self.startDate timeIntervalSinceNow];
		//	NSLog(@"interval: %@, %f", self.startDate, interval); 
		//	self.activeTaskSession.secondsWorked = [NSNumber numberWithInteger: abs(interval)];
	NSLog(@"incrementBreakTime: %d", secondsRemainingInBreak);
	
	if(secondsRemainingInBreak > 0){
		NSString *content  = [NSString stringWithFormat:@"%d seconds remaining in break",secondsRemainingInBreak ];
		[self.countdownLabel setStringValue:content];
		secondsRemainingInBreak = secondsRemainingInBreak - 1;
	}else{
		[self.breakTimer invalidate];
		self.breakTimer = nil;
		
		[self.countdownLabel setHidden:YES];
		[self.stillAroundButton setHidden:NO];
			//[self.stillAroundButton becomeFirstResponder];

		NSTimeInterval interval = 5.0; //todo: allow user preference setting
		self.stopTaskTimer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(stopCurrentTask:) userInfo: nil repeats:YES];
		
		[[NSRunLoop currentRunLoop] addTimer: self.stopTaskTimer
									 forMode:NSModalPanelRunLoopMode];
	}
}


-(IBAction) stillAroundConfirmation:(id) sender{
	[self.stopTaskTimer invalidate];
	self.stopTaskTimer = nil;
	[[NSApplication sharedApplication] stopModalWithCode:0];

		//[self.breakWindow orderBack:sender];
	[self.breakWindow close];	
	
		//	[self.appController.mainWindow orderFront:sender];

		//[NSMenu setMenuBarVisible:YES];
}

- (void) stopCurrentTask:(id) userInfo{
	[self.stopTaskTimer invalidate];
	self.stopTaskTimer = nil;
	
	NSLog(@"Stopping current task");
	[appController stopTask];
}

-(void) showBreakWindow:(id) sender{
	if (![NSBundle loadNibNamed:@"Break" owner:self]) {
		NSLog(@"Error loading Nib for Break!");
	} else {
		NSLog(@"showBreakWindow");
		
		NSModalSession session = [[NSApplication sharedApplication] beginModalSessionForWindow:self.breakWindow];
				
		/*** Show Window ***/
			//[NSMenu setMenuBarVisible:NO];
		
		[breakWindow setOpaque:NO];
		[breakWindow setAlphaValue:.8];
		[breakWindow setStyleMask:NSBorderlessWindowMask];
		
		[breakWindow
			 setFrame:[breakWindow frameRectForContentRect:[[breakWindow screen] frame]]
			 display:YES
			 animate:YES];
		
		[self.breakWindow orderFront:sender];
		
		/*** Set up Timer. 
		 
		 This MUST be scheduled in the modal run loop
		 
		 ***/
		secondsRemainingInBreak = 5 ; //todo: allow user preference setting
		self.breakTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(incrementBreakTime:) userInfo: nil repeats:YES];
		[[NSRunLoop currentRunLoop] addTimer: self.breakTimer
									 forMode:NSModalPanelRunLoopMode];
		
		[self incrementBreakTime:nil];

		//this for loop allows the break timer to run periodically.
		// without this loop, the timer would never get invoked
		for (;;) {
			if ([NSApp runModalSession:session] != NSRunContinuesResponse)
				break;
		}
		[NSApp endModalSession:session];
	}
}

-(void)dealloc{
	[appController release];
	[breakTimer release];
	
	[super dealloc];
	
}


@end

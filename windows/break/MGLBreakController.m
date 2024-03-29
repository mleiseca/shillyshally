//
//  MGLBreakController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/11/10.
//  .
//

#import "MGLBreakController.h"
#import "SSWindowController.h"
#import "SSConstants.h"

@implementation MGLBreakController

@synthesize breakWindow;
@synthesize countdownLabel;
@synthesize breakTimer;
@synthesize stopTaskTimer;
@synthesize stillAroundButton;
@synthesize appController;


- (id) initWithAppController: (SSWindowController *) appControllerArg{
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

		if ( ! [appController taskInProgress] ){
			//no currently selected task. deactivate break screen
			[[NSApplication sharedApplication] stopModalWithCode:0];
			[self.breakWindow close];	
		}else{
			[self.countdownLabel setHidden:YES];
			[self.stillAroundButton setHidden:NO];
			//[self.stillAroundButton becomeFirstResponder];
			
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			NSTimeInterval interval = [defaults doubleForKey:SSPrefBreakStillAroundConfirmationInterval];
			
			self.stopTaskTimer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(stopCurrentTask:) userInfo: nil repeats:YES];
			
			[[NSRunLoop currentRunLoop] addTimer: self.stopTaskTimer
										 forMode:NSModalPanelRunLoopMode];
			
		}
		
	}
}


-(IBAction) stillAroundConfirmation:(id) sender{
		
	[self.stopTaskTimer invalidate];
	self.stopTaskTimer = nil;
	[[NSApplication sharedApplication] stopModalWithCode:0];

	[self.breakWindow close];	

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
		
		/***
		 
		 Push break window to take over whole screen
		 
		 Found clues here:
		 - http://www.cocoabuilder.com/archive/cocoa/284023-prevent-nswindow-from-hiding-with-app.html
		 ***/
		 
		 
		[breakWindow setOpaque:NO];
		[breakWindow setAlphaValue:.8];
		[breakWindow setStyleMask:NSBorderlessWindowMask];
		
		[breakWindow
			 setFrame:[breakWindow frameRectForContentRect:[[breakWindow screen] frame]]
			 display:YES
			 animate:YES];

		//[breakWindow setLevel:NSPopUpMenuWindowLevel ];
		[breakWindow orderFront:sender];
		
		
		/*** 
		 
		 Set up Timer. 
		 
		 This MUST be scheduled in the modal run loop
		 
		 ***/
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		secondsRemainingInBreak = [defaults integerForKey:SSPrefBreakDuration];
		
		NSModalSession session = [[NSApplication sharedApplication] beginModalSessionForWindow:self.breakWindow];

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

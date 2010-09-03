//
//  MGLTableView.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  .
//

#import "SSTaskTableView.h"
#import "SSWindowController.h"


@implementation SSTaskTableView

@synthesize windowController;

- (void)keyDown:(NSEvent *)theEvent{
	short keyCode = [theEvent keyCode];
	//	NSLog(@"keyDown: %d", keyCode );
	
	
		
		
	if(keyCode == 123){
		//left arrow
		[windowController changeSelectedTaskProjectUp];
		return;
	}else if(keyCode == 124){
		//right arrow
		[windowController changeSelectedTaskProjectDown];
		return;
	}
	
	[super keyDown:theEvent];
	
}

@end

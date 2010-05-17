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
	
	unsigned flags = [theEvent modifierFlags];

    BOOL isShiftPressed = (flags & NSShiftKeyMask)  == NSShiftKeyMask ;
	BOOL isCommandPressed = (flags & NSCommandKeyMask)  == NSCommandKeyMask;
	
	if(isShiftPressed || isCommandPressed){
		if (isShiftPressed && isCommandPressed){
			if(keyCode == 40){
				//command shift k = start/stop				
				[windowController toggleSelectedTask:self];
				return;
			}else if(keyCode == 14){
				//command shift e = done 
				[windowController finishTask:self];
				return;
			}
		}
		
	}else if(keyCode == 123){
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

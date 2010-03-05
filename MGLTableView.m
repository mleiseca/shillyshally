//
//  MGLTableView.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTableView.h"
#import "MGLTaskAppController.h"


@implementation MGLTableView

@synthesize appController;

- (void)keyDown:(NSEvent *)theEvent{
	short keyCode = [theEvent keyCode];
	//NSLog(@"keyDown: %d", keyCode );	
	
	if(keyCode == 123){
		[appController changeSelectedTaskProjectUp];
		//left arrow
	}else if(keyCode == 124){
		//right arrow
		[appController changeSelectedTaskProjectDown];
	}else{
		[super keyDown:theEvent];
	}
}

@end

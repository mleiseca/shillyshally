//
//  MGLArrayController_CompletedTaskFilter.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/21/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLArrayController_CompletedTaskFilter.h"


@implementation MGLArrayController_CompletedTaskFilter

- (NSArray *)arrangeObjects:(NSArray *)objects {

	// pg 77 CocoaBindings.pdf
	// might be a useful feature if I have a lot going on?
    //if (searchString == nil) {
//        return [super arrangeObjects:objects];
//    }
	
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[objects count]];
    NSEnumerator *objectsEnumerator = [objects objectEnumerator];
    id item;
	
    while (item = [objectsEnumerator nextObject]) {
		if ([item respondsToSelector:@selector(completedDate)]){
			if([item completedDate] == nil){
				[filteredObjects addObject:item];
			}
		}
    }
    return [super arrangeObjects:filteredObjects];
}


@end

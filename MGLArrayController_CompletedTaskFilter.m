//
//  MGLArrayController_CompletedTaskFilter.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/21/10.
//  .
//

#import "MGLArrayController_CompletedTaskFilter.h"
#import "SSProject.h"
#import "SSProject+Related.h"

@implementation MGLArrayController_CompletedTaskFilter
@synthesize currentProject;

- (NSArray *)arrangeObjects:(NSArray *)objects {

	// pg 77 CocoaBindings.pdf
	// might be a useful feature if I have a lot going on?
    //if (searchString == nil) {
//        return [super arrangeObjects:objects];
//    }
	
	NSLog(@"Array Controller for Tasks: arrangeObjets");
	
	
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[objects count]];
    NSEnumerator *objectsEnumerator = [objects objectEnumerator];
    id item;
	
	NSSet *relatedProjects = nil;
	if (currentProject){
		NSLog(@"filtering by project");
		
		relatedProjects = [currentProject relatedProjects];
	}else{
		NSLog(@"NOT filtering by project");
	}

    while (item = [objectsEnumerator nextObject]) {
		if ([item respondsToSelector:@selector(completedDate)]){
			if([item valueForKey:@"completedDate"] == nil){
				
				if (! relatedProjects || ! [item project] || [relatedProjects containsObject:[item project]]){
					[filteredObjects addObject:item];					
				}
			}
		}
    }
	
    return [super arrangeObjects:filteredObjects];
}


@end

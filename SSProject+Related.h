//
//  SSProject+RecursiveTasks.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/21/10.

//

#import <Cocoa/Cocoa.h>
#import "SSProject.h"


@interface SSProject(related)


/*
 This method returns a set contain the target and all its descendants
 */
- (NSSet *) relatedProjects;

@end

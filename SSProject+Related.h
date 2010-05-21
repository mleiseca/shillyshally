//
//  SSProject+RecursiveTasks.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/21/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SSProject.h"


@interface SSProject(related)

- (NSSet *) relatedProjects;

- (void) helperAddRelatedProjects: (NSMutableSet *) relatedProjects;

@end

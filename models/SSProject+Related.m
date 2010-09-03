//
//  SSProject+RecursiveTasks.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/21/10.

//

#import "SSProject+Related.h"


@implementation SSProject(related)


- (void) helperAddRelatedProjects: (NSMutableSet *) allProjects{
	
	[allProjects addObject:self];
	
	SSProject *project;
	for (project in self.childProjects){
		[project helperAddRelatedProjects:allProjects];		
	}
}

- (NSSet*) relatedProjects{

	NSMutableSet *allProjects = [[NSMutableSet alloc] init];

	[self helperAddRelatedProjects:allProjects];
	
	[allProjects autorelease];
	
	return allProjects;
}


@end

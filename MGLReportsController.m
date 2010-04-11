//
//  MGLReports.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLReportsController.h"


@implementation MGLReportsController

@synthesize reportingWindow;


-(void) showReportsWindow:(id) sender{
	if (![NSBundle loadNibNamed:@"Reports" owner:self]) {
		NSLog(@"Error loading Nib for document!");
	} else {
		NSLog(@"showReportsWindow");
		
		NSManagedObjectContext *context  = [[NSApp delegate] managedObjectContext];
		NSManagedObjectModel   *model    = [[NSApp delegate] managedObjectModel];
		NSDictionary           *entities = [model entitiesByName];
		NSEntityDescription    *entity   = [entities valueForKey:@"MGLTask"];
		
		NSDate *date = [[NSDate date] dateByAddingTimeInterval:-1000000];

		NSPredicate * predicate;
		predicate = [NSPredicate predicateWithFormat:@"ANY taskSessions.createDate > %@", date];
		
	//	NSSortDescriptor * sort = [[NSortDescriptor alloc] initWithKey:@"title"];
	//	NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
		
		NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
		[fetch setEntity: entity];
		[fetch setPredicate: predicate];
	//	[fetch setSortDescriptors: sortDescriptors];
		
		NSArray * results = [context executeFetchRequest:fetch error:nil];
	//	[sort release];
	//	[fetch release];
		
	//	NSArray *testFetchResults = 
	//	[context fetchObjectsForEntityName:@"MGLTask" 
	//						 withPredicate:[NSString stringWithFormat:@"ANY taskSessions.createDate > %@", date]]; 
	//	
	//	
		
	//	NSLog([[(MGLTask *)[testFetchResults objectAtIndex:0] books] valueForKey:@"name"]);
		NSLog(@"%@", results );
		[results release];
		
		[self.reportingWindow orderFront:sender];
			   
	}
}

- (void)dealloc {
	[super dealloc];
}

@end

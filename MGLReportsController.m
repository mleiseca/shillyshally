//
//  MGLReports.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLReportsController.h"
#import "SSTaskReport.h"


@implementation MGLReportsController

@synthesize reportingWindow;
@synthesize datePicker;
@synthesize contentsView;


- (IBAction) generateReport:(id)sender{
	
	NSManagedObjectContext *context  = [[NSApp delegate] managedObjectContext];
	NSManagedObjectModel   *model    = [[NSApp delegate] managedObjectModel];
	NSDictionary           *entities = [model entitiesByName];
	NSEntityDescription    *entity   = [entities valueForKey:@"MGLTask"];
	
	//NSDate *date = [[NSDate date] dateByAddingTimeInterval:-1000000];
	//NSPredicate * predicate = [NSPredicate predicateWithFormat:@"ANY taskSessions.createDate > %@", date];
	
	NSDate *startDate = [self.datePicker  dateValue];
	
	NSLog(@"Using date: %@", startDate );

	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.day = 1;
	NSDate *endDate = [gregorian dateByAddingComponents:components toDate:startDate options:0];
	[components release];

	/*

	 nextDay now has the same hour, minute, and second as the original date (today).
	 To normalize to midnight, extract the year, month, and day components and create a new date from those components.
	 */
	 components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
				 fromDate: endDate];
	endDate = [gregorian dateFromComponents:components];	
	
	components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
				 fromDate: startDate];
	startDate = [gregorian dateFromComponents:components];	
	
	//get tasks which have a taskSession after the start and before the end
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(taskSessions, $x, $x.createDate >= %@ AND $x.createDate <= %@) != 0)",
						 startDate, endDate];
	
	//	NSSortDescriptor * sort = [[NSortDescriptor alloc] initWithKey:@"title"];
	//	NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
	
	NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity: entity];
	[fetch setPredicate: predicate];
	//	[fetch setSortDescriptors: sortDescriptors];
	
	NSArray * results = [context executeFetchRequest:fetch error:nil];
	NSLog(@"%@", results );
	
	
	//NSRect frame = NSMakeRect(10, 10, 20, 20);
	//SView *slice = [[SSTaskReport alloc] initWithFrame:frame];
	
	//[self.contentsView addSubview:slice]; 
	
	
	
}

-(void) showReportsWindow:(id) sender{

	if (![NSBundle loadNibNamed:@"Reports" owner:self]) {
		NSLog(@"Error loading Nib for document!");
	} else {
		NSLog(@"showReportsWindow");
		
		[self.datePicker setDateValue:[NSDate date]];
		
		[self generateReport:self];
		
		[self.reportingWindow orderFront:sender];
			   
	}
}

- (void)dealloc {
	[super dealloc];
}

@end

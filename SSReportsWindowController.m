//
//  MGLReports.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/5/10.
//  .
//

#import "SSReportsWindowController.h"
#import "SSTaskReport.h"
#import "SSTaskReportDayView.h"

@implementation SSReportsWindowController

@synthesize contentsView;
@synthesize selectedStartDate;
@synthesize dateTypeSelection;
@synthesize selectedStartDateTextField;

- (IBAction) generateReport:(id)sender{
	
	NSManagedObjectContext *context  = [[NSApp delegate] managedObjectContext];
	NSManagedObjectModel   *model    = [[NSApp delegate] managedObjectModel];
	NSDictionary           *entities = [model entitiesByName];
	NSEntityDescription    *entity   = [entities valueForKey:@"SSTask"];
	
	//NSDate *date = [[NSDate date] dateByAddingTimeInterval:-1000000];
	//NSPredicate * predicate = [NSPredicate predicateWithFormat:@"ANY taskSessions.createDate > %@", date];
	
	NSDate *startDate =self.selectedStartDate;
	
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
	// http://www.cocoabuilder.com/archive/cocoa/210757-nspredicate-for-any-match-based-on-two-properties-at-once.html
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(taskSessions, $x, $x.createDate >= %@ AND $x.createDate <= %@) != 0)",
						 startDate, endDate];
	
	//	NSSortDescriptor * sort = [[NSortDescriptor alloc] initWithKey:@"title"];
	//	NSArray * sortDescriptors = [NSArray arrayWithObject: sort];
	
	NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity: entity];
	[fetch setPredicate: predicate];
	//	[fetch setSortDescriptors: sortDescriptors];
	
	NSArray * results = [context executeFetchRequest:fetch error:nil];
	
	SSTaskReport *report = [[SSTaskReport alloc] initWithStartDate:startDate withEndDate:endDate];
	[report.tasks addObjectsFromArray:results];
	
	NSLog(@"%@", report.tasks );
	
	SSTaskReportDayView *dayView = [[SSTaskReportDayView alloc] initWithFrame:self.contentsView.frame];
	dayView.taskReport = report;
	[self.contentsView addSubview:dayView]; 	
}

- (void) updateStartDate: (NSDate *) date{
	
	self.selectedStartDate = date;
	[self.selectedStartDateTextField setObjectValue:date];
	//[self.selectedStartDateTextField setStringValue:@"foo"];
	NSLog(@"Using date: %@", date );

}

-(void) showReportsWindow:(id) sender{

	if (![NSBundle loadNibNamed:@"Reports" owner:self]) {
		NSLog(@"Error loading Nib for document!");
	} else {
		NSLog(@"showReportsWindow");
		
		//[self.datePicker setDateValue:];
		
		[self updateStartDate: [NSDate date]];
		[self generateReport:self];
		
		[self.window orderFront:sender];
	}
}


- (IBAction) nextDate: (id)sender{
	NSLog(@"nextDate");
	
}
- (IBAction) previousDate: (id)sender{	
	NSLog(@"previousDate");

}
- (IBAction) selectedDateType: (id)sender{
	NSLog(@"selectedDateType");
}

- (void)dealloc {
	[super dealloc];
}

@end

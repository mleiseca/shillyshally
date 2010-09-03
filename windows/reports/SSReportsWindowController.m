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
@synthesize currentReportView;


- (IBAction) generateReport:(id)sender{
	
	NSManagedObjectContext *context  = [[NSApp delegate] managedObjectContext];
	NSManagedObjectModel   *model    = [[NSApp delegate] managedObjectModel];
	NSDictionary           *entities = [model entitiesByName];
	NSEntityDescription    *entity   = [entities valueForKey:@"SSTask"];
	
	
	//todo: move this. i don't really know why, but adding new task will make it appear on reports, until the context is saved
	NSError *err;
	[context save:&err];
	
	//NSDate *date = [[NSDate date] dateByAddingTimeInterval:-1000000];
	//NSPredicate * predicate = [NSPredicate predicateWithFormat:@"ANY taskSessions.createDate > %@", date];
	
	NSDate *startDate =self.selectedStartDate;
	
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

	NSLog(@"Using start date: %@, end date %@", startDate, endDate );

	//get tasks which have a taskSession after the start and before the end
	// http://www.cocoabuilder.com/archive/cocoa/210757-nspredicate-for-any-match-based-on-two-properties-at-once.html
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SUBQUERY(taskSessions, $x, $x.createDate >= %@ AND $x.createDate <= %@) != 0)",
						 startDate, endDate];
	

	NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity: entity];
	[fetch setPredicate: predicate];
	
	NSArray * results = [context executeFetchRequest:fetch error:nil];
	
	SSTaskReport *report = [[SSTaskReport alloc] initWithStartDate:startDate withEndDate:endDate];
	[report.tasks addObjectsFromArray:results];
	
	NSLog(@"%@", results );
	
	[self.currentReportView removeFromSuperview];
	
	SSTaskReportDayView *dayView = [[SSTaskReportDayView alloc] initWithFrame:self.contentsView.frame];
	dayView.taskReport = report;
	
	self.currentReportView = dayView;
	[dayView release];
	[report release];
	[self.contentsView addSubview:dayView]; 	
}

- (void) updateStartDate: (NSDate *) date{
	
	self.selectedStartDate = date;
	[self.selectedStartDateTextField setObjectValue:date];
	//[self.selectedStartDateTextField setStringValue:@"foo"];
	NSLog(@"Using date: %@", date );

}

- (void) generateReportWithDate:(NSDate *)date{
	[self updateStartDate:date ];
	[self generateReport:nil];
}

-(void) showReportsWindow:(id) sender{

	if (![NSBundle loadNibNamed:@"Reports" owner:self]) {
		NSLog(@"Error loading Nib for document!");
	} else {
		NSLog(@"showReportsWindow");
		
		[self generateReportWithDate:[NSDate date]];
		[self.window orderFront:sender];
	}
}


- (IBAction) nextDate: (id)sender{
	[self generateReportWithDate:[self.selectedStartDate dateByAddingTimeInterval:86400]];
}
- (IBAction) previousDate: (id)sender{	
	[self generateReportWithDate:[self.selectedStartDate dateByAddingTimeInterval:-86400]];

}
- (IBAction) selectedDateType: (id)sender{
	NSLog(@"selectedDateType");
}

- (void)dealloc {
	[super dealloc];
}

@end

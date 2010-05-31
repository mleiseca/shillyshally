//
//  MGLReports.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/5/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class SSTaskReport;
@interface SSReportsWindowController : NSWindowController {

	NSDate *selectedStartDate;
	NSView *contentsView;
	SSTaskReport *taskReport;
	
	NSSegmentedControl *dateTypeSelection;
	NSTextField *selectedStartDateTextField;

}

@property (nonatomic, retain) IBOutlet NSView *contentsView;
@property (nonatomic, retain) NSDate *selectedStartDate;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *dateTypeSelection;
@property (nonatomic, retain) IBOutlet NSTextField *selectedStartDateTextField;

- (IBAction) showReportsWindow:(id) sender;
- (IBAction) generateReport:(id)sender;
- (IBAction) nextDate: (id)sender;
- (IBAction) previousDate: (id)sender;
- (IBAction) selectedDateType: (id)sender;


@end

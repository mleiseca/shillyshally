//
//  MGLReports.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/5/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class SSTaskReport;
@interface MGLReportsController : NSObject {

	NSWindow *reportingWindow;
	NSDatePicker *datePicker;
	
	NSView *contentsView;
	SSTaskReport *taskReport;
	

}

@property (nonatomic, retain) IBOutlet NSWindow *reportingWindow;
@property (nonatomic, retain) IBOutlet NSDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet NSView *contentsView;

-(IBAction) showReportsWindow:(id) sender;
- (IBAction) generateReport:(id)sender;

@end

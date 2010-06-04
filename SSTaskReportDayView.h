//
//  SSSingleTaskView.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/10/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class SSTaskReport;

@interface SSTaskReportDayView : NSView {
	SSTaskReport *taskReport;
}

@property (nonatomic, retain) SSTaskReport *taskReport;

@end

//
//  MGLReports.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MGLReportsController : NSObject {

	NSWindow *reportingWindow;

}

@property (nonatomic, retain) IBOutlet NSWindow *reportingWindow;

-(void) showReportsWindow:(id) sender;

@end

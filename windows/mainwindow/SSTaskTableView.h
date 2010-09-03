//
//  MGLTableView.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class SSWindowController;

@interface SSTaskTableView : NSTableView {
	SSWindowController *windowController;
	
}

@property(nonatomic, retain) IBOutlet SSWindowController *windowController;

@end

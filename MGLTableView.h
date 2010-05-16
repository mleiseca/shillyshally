//
//  MGLTableView.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class MGLTaskAppController;

@interface MGLTableView : NSTableView {
	MGLTaskAppController *appController;
	
}

@property(nonatomic, retain) IBOutlet MGLTaskAppController *appController;

@end

//
//  MGLTableView.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MGLTaskAppController;

@interface MGLTableView : NSTableView {
	MGLTaskAppController *appController;
	
}

@property(nonatomic, retain) IBOutlet MGLTaskAppController *appController;

@end

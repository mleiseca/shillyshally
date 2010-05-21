//
//  MGLArrayController_CompletedTaskFilter.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/21/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class SSProject;

@interface MGLArrayController_CompletedTaskFilter : NSArrayController {
	SSProject *currentProject;
}


@property(nonatomic, retain) SSProject *currentProject;
@end

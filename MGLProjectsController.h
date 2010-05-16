//
//  MGLProjectsController.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/10/10.
//  .
//

#import <Cocoa/Cocoa.h>


@interface MGLProjectsController : NSObject {
	NSWindow *projectsWindow;
	
	
	NSArrayController *projectsArrayController;
}

@property (nonatomic, retain) IBOutlet NSWindow *projectsWindow;
@property (nonatomic, retain) IBOutlet NSArrayController *projectsArrayController;

-(void) showProjectsWindow:(id) sender;


@end

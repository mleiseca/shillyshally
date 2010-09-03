//
//  MGLProjectsController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/10/10.
//  .
//

#import "MGLProjectsController.h"


@implementation MGLProjectsController

@synthesize projectsWindow;
@synthesize projectsArrayController;

-(void) showProjectsWindow:(id)sender{
	if (![NSBundle loadNibNamed:@"Projects" owner:self]) {
		NSLog(@"Error loading Nib for document!");
	} else {
		NSLog(@"showProjectsWindow");
		
		NSManagedObjectContext *context  = [[NSApp delegate] managedObjectContext];
		[self.projectsArrayController setManagedObjectContext:context];
		
		[self.projectsWindow orderFront:sender];
	}
}

- (void)dealloc {
	[super dealloc];
}

@end

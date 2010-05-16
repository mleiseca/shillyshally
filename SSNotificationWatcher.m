//
//  SSNotificationWatcher.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/8/10.
//  .
//

#import "SSNotificationWatcher.h"
#import "MGLTask.h"
#import "MGLTaskSession.h"



@implementation SSNotificationWatcher

- (id) init{
	
	if(! [super init])
		return nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(managedObjectContextDidChange:) 
												 name:NSManagedObjectContextObjectsDidChangeNotification 
											   object:[[NSApp delegate] managedObjectContext]];
	
	return self;
}

- (void)managedObjectContextDidChange:(NSNotification *)notification {
    // Get a set containing ALL objects which have been changed
    NSSet *updatedObjects = [[notification userInfo]
							 objectForKey:NSUpdatedObjectsKey];
    
	id updatedObject = nil;
	for (updatedObject in updatedObjects){
			
		if ([updatedObject class] == [MGLTaskSession class]){
			NSLog(@"updating task with current time");
			MGLTask *task = [updatedObject task];
			[task willChangeValueForKey:@"timeWorked"];
			[task didChangeValueForKey:@"timeWorked"];
		}
	}
}
@end

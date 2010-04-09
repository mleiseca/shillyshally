//
//  WorkTimerWithPersistence_AppDelegate.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright Grubhub Inc 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MGLTaskAppController;
@class MGLReportsController;

@interface WorkTimerWithPersistence_AppDelegate : NSObject 
{
    NSWindow *window;
	NSWindow *projectsWindow;
	MGLReportsController *reportController;
	
	MGLTaskAppController *appController;
	
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet NSWindow *projectsWindow;
@property (nonatomic, retain) IBOutlet MGLReportsController *reportController;

@property (nonatomic, retain) IBOutlet 	MGLTaskAppController *appController;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;

-(IBAction) openProjectsWindow:(id) sender;
-(IBAction) openReportingWindw:(id) sender;

- (NSUndoManager *)applicationUndoManager;

@end

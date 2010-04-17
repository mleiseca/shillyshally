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
@class MGLProjectsController;
@class MGLBreakController;

@interface WorkTimerWithPersistence_AppDelegate : NSObject 
{
    NSWindow *window;
	MGLProjectsController *projectsController;
	MGLReportsController  *reportController;
	MGLBreakController    *breakController;
	
	MGLTaskAppController *appController;
	
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet MGLTaskAppController *appController;

@property (nonatomic, retain) MGLProjectsController *projectsController;
@property (nonatomic, retain) MGLReportsController  *reportController;
@property (nonatomic, retain) MGLBreakController *breakController;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;

-(IBAction) openProjectsWindow:(id) sender;
-(IBAction) openReportingWindw:(id) sender;
-(IBAction) startBreak:(id) sender;

- (NSUndoManager *)applicationUndoManager;

@end

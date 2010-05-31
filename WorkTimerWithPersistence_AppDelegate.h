//
//  WorkTimerWithPersistence_AppDelegate.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright Grubhub Inc 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SSWindowController;
@class SSReportsWindowController;
@class MGLProjectsController;
@class MGLBreakController;
@class MGLPreferencesController;
@class SSBreakTimer;
@class SSNotificationWatcher;

@interface WorkTimerWithPersistence_AppDelegate : NSObject 
{
	MGLBreakController    *breakController;
	MGLPreferencesController *preferencesController;
	
	SSBreakTimer *breakTimer;
	
	SSWindowController *windowController;
	
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	NSTimer *saveTimer;
	
	SSNotificationWatcher *notificationWatcher;
}

@property (nonatomic, retain) SSWindowController *windowController;

@property (nonatomic, retain) MGLBreakController *breakController;
@property (nonatomic, retain) MGLPreferencesController *preferencesController;
@property (nonatomic, retain) SSBreakTimer *breakTimer;
@property (nonatomic, retain) SSNotificationWatcher *notificationWatcher;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSTimer *saveTimer;

//- (IBAction)saveAction:sender;

-(IBAction) startBreak:(id) sender;

-(IBAction) openPreferencesWindow: (id) sender;


- (NSUndoManager *)applicationUndoManager;

@end

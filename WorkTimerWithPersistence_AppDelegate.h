//
//  WorkTimerWithPersistence_AppDelegate.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright Grubhub Inc 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WorkTimerWithPersistence_AppDelegate : NSObject 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;

@end

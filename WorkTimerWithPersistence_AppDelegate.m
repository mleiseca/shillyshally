//
//  WorkTimerWithPersistence_AppDelegate.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright Grubhub Inc 2010 . All rights reserved.
//

#import "WorkTimerWithPersistence_AppDelegate.h"
#import "SSWindowController.h"
#import "SSReportsWindowController.h"
#import "MGLProjectsController.h"
#import "MGLBreakController.h"
#import "MGLPreferencesController.h"
#import "SSNotificationWatcher.h"

#import "SSConstants.h"
#import "SSBreakTimer.h"

@implementation WorkTimerWithPersistence_AppDelegate

@synthesize windowController;

@synthesize breakController;
@synthesize preferencesController;
@synthesize breakTimer;
@synthesize notificationWatcher;

@synthesize saveTimer;

+ (void) initialize{
	
	NSMutableDictionary *defaults = [[NSMutableDictionary alloc] init];

	[defaults setObject:@"1" forKey:SSPrefBreakEnabled];	

	//in seconds
	[defaults setObject:@"10" forKey:SSPrefBreakDuration];
	
	//in minutes
	[defaults setObject:@"10" forKey:SSPrefBreakInterval];
	
	//in seconds
	[defaults setObject:@"120" forKey:SSPrefBreakStillAroundConfirmationInterval];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
	
	[defaults release];
}


-(IBAction) startBreak:(id) sender{
	NSLog(@"Starting Break");
	if( breakController == nil){
		self.breakController = [[MGLBreakController alloc] initWithAppController:self.windowController];
	}
	
	[self.breakController showBreakWindow:sender];
	
}

-(IBAction) openPreferencesWindow: (id) sender{
	if (! preferencesController){
		preferencesController = [[MGLPreferencesController alloc] init];
	}
	
	[preferencesController showWindow:self];
}

#pragma mark -
#pragma mark Core Data

/**
    Returns the support directory for the application, used to store the Core Data
    store file.  This code uses a directory named "WorkTimerWithPersistence" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportDirectory {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"WorkTimerWithPersistence"];
}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle.
 */
 
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel) return managedObjectModel;
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The directory for the store is created, 
    if necessary.)
 */

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

    if (persistentStoreCoordinator) return persistentStoreCoordinator;

    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSAssert(NO, @"Managed object model is nil");
        NSLog(@"%@:%s No model to generate a store from", [self class], _cmd);
        return nil;
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *applicationSupportDirectory = [self applicationSupportDirectory];
    NSError *error = nil;
    
    if ( ![fileManager fileExistsAtPath:applicationSupportDirectory isDirectory:NULL] ) {
		if (![fileManager createDirectoryAtPath:applicationSupportDirectory withIntermediateDirectories:NO attributes:nil error:&error]) {
            NSAssert(NO, ([NSString stringWithFormat:@"Failed to create App Support directory %@ : %@", applicationSupportDirectory,error]));
            NSLog(@"Error creating application support directory at %@ : %@",applicationSupportDirectory,error);
            return nil;
		}
    }
    
    NSURL *url = [NSURL fileURLWithPath: [applicationSupportDirectory stringByAppendingPathComponent: dataFileLocation ]];
    
	NSLog(@"Using data file: %@", url);
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: mom];
    //if (![persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType 
//                                                configuration:nil 
//                                                URL:url 
//                                                options:nil 
//                                                error:&error]){
//        
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, 
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
	
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
											configuration:nil 
											URL:url 
											options:options 
											error:&error]){
		   
		   
		[[NSApplication sharedApplication] presentError:error];
        [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
        return nil;
    }    

    return persistentStoreCoordinator;
}

/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext) return managedObjectContext;

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator: coordinator];

    return managedObjectContext;
}

/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}

- (NSUndoManager *)applicationUndoManager{
    return [[self managedObjectContext] undoManager];		
}

/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
/*
- (IBAction) saveAction:(id)sender {

    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%s unable to commit editing before saving", [self class], _cmd);
    }

    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}
 */




#pragma mark -
#pragma mark App/Window

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber *breakInterval = [defaults objectForKey:SSPrefBreakInterval];
	self.breakTimer = [[SSBreakTimer alloc] initWithBreakIntervalInMinutes:breakInterval];
	
	self.notificationWatcher = [[SSNotificationWatcher alloc] init];
}


// -------------------------------------------------------------------------------
//	applicationDidFinishLaunching:notification
// -------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
	self.saveTimer = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:managedObjectContext selector:@selector(save:) userInfo: nil repeats:YES];
	
	// load the app's main window for display
	windowController = [[SSWindowController alloc] initWithWindowNibName:@"MainWindow"];
	windowController.appDelegate = self;
	[windowController showWindow:self];
}


/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {

    if (!managedObjectContext) return NSTerminateNow;

    if (![managedObjectContext commitEditing]) {
        NSLog(@"%@:%s unable to commit editing to terminate", [self class], _cmd);
        return NSTerminateCancel;
    }

    if (![managedObjectContext hasChanges]) return NSTerminateNow;

    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
    
        // This error handling simply presents error information in a panel with an 
        // "Ok" button, which does not include any attempt at error recovery (meaning, 
        // attempting to fix the error.)  As a result, this implementation will 
        // present the information to the user and then follow up with a panel asking 
        // if the user wishes to "Quit Anyway", without saving the changes.

        // Typically, this process should be altered to include application-specific 
        // recovery steps.  
                
        BOOL result = [sender presentError:error];
        if (result) return NSTerminateCancel;

        NSString *question = NSLocalizedString(@"Could not save changes while quitting.  Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        [alert release];
        alert = nil;
        
        if (answer == NSAlertAlternateReturn) return NSTerminateCancel;

    }

    return NSTerminateNow;
}


/**
    Implementation of dealloc, to release the retained variables.
 */
 
- (void)dealloc {

    [windowController release];
	[breakController release];
	[breakTimer release];
	[notificationWatcher release];
	
    [managedObjectContext release];
    [persistentStoreCoordinator release];
    [managedObjectModel release];
	
    [super dealloc];
}


@end

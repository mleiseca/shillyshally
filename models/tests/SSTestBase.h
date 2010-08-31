//
//  SSTestBase.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 7/11/10.

//

#import <Foundation/Foundation.h>

#import "GTMSenTestCase.h"

@interface SSTestBase : GTMTestCase {
	NSPersistentStoreCoordinator *coord;
    NSManagedObjectContext *ctx;
    NSManagedObjectModel *model;
    NSPersistentStore *store;
}

@property(nonatomic, retain) NSPersistentStoreCoordinator *coord;
@property(nonatomic, retain) NSManagedObjectContext *ctx;
@property(nonatomic, retain) NSManagedObjectModel *model;
@property(nonatomic, retain) NSPersistentStore *store;

@end

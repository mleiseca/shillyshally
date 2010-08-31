//
//  SSTestBase.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 7/11/10.

//

#import "SSTestBase.h"


@implementation SSTestBase

@synthesize model, coord, store, ctx;

- (void)setUp
{
    model = [[NSManagedObjectModel mergedModelFromBundles: nil] retain];
    coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
	//    NSLog(@"model: %@", model);
    store = [coord addPersistentStoreWithType: NSInMemoryStoreType
                                configuration: nil
                                          URL: nil
                                      options: nil 
                                        error: NULL];
    ctx = [[NSManagedObjectContext alloc] init];
    [ctx setPersistentStoreCoordinator: coord];
	NSLog(@"done with setup for Core data");
}

- (void)tearDown
{
	[ctx release];
    NSError *error = nil;
    STAssertTrue([coord removePersistentStore: store error: &error], 
                 @"couldn't remove persistent store: %@", error);
    store = nil;
	[coord release];
	[model release];
}

@end

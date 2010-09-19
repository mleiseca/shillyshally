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
	model = [[NSManagedObjectModel alloc] initWithContentsOfURL:
			 [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"WorkTimerWithPersistence_DataModel" ofType:@"momd"]]];

    model = [[NSManagedObjectModel mergedModelFromBundles: nil] retain];
    coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
	NSLog(@"model entities: %d", [model.entities count]);
	STAssertNotEquals([model.entities count], 0, @"Entity count should be greater than zero");
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

-(id)newEntity:(NSString*)entityName{
	return [[NSClassFromString(entityName) alloc] initWithEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:ctx] 
                                  insertIntoManagedObjectContext:ctx];	
}

@end

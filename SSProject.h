//
//  MGLProject.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/28/10.
//  .
//

#import <CoreData/CoreData.h>

@class SSTask;

@interface SSProject :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet* tasks;

- (NSString *) timeWorked;
- (NSDate *) workStartDate;

@end


@interface SSProject (CoreDataGeneratedAccessors)
- (void)addTasksObject:(SSTask *)value;
- (void)removeTasksObject:(SSTask *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end


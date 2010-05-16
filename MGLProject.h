//
//  MGLProject.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/28/10.
//  .
//

#import <CoreData/CoreData.h>

@class MGLTask;

@interface MGLProject :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet* tasks;

- (NSString *) timeWorked;
- (NSDate *) workStartDate;

@end


@interface MGLProject (CoreDataGeneratedAccessors)
- (void)addTasksObject:(MGLTask *)value;
- (void)removeTasksObject:(MGLTask *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end


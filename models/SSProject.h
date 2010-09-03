//
//  SSProject.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import <CoreData/CoreData.h>

@class SSTask;

@interface SSProject :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet* childProjects;
@property (nonatomic, retain) NSSet* tasks;
@property (nonatomic, retain) SSProject * parentProject;
@property (nonatomic, retain) NSNumber* isStarred;

@end


@interface SSProject (CoreDataGeneratedAccessors)
- (void)addChildProjectsObject:(SSProject *)value;
- (void)removeChildProjectsObject:(SSProject *)value;
- (void)addChildProjects:(NSSet *)value;
- (void)removeChildProjects:(NSSet *)value;

- (void)addTasksObject:(SSTask *)value;
- (void)removeTasksObject:(SSTask *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end


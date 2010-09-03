//
//  MGLTask.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  .
//

#import <CoreData/CoreData.h>

@class SSProject;
@class SSTaskSession;

@interface SSTask :  NSManagedObject
{
	BOOL running;
}

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * meeting;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * ticketId;
@property (nonatomic, retain) NSNumber * hoursEstimate;
@property (nonatomic, retain) SSProject * project;
@property (nonatomic, retain) NSSet* taskSessions;
@property (nonatomic, assign) BOOL running;
@property (nonatomic, retain) NSNumber* isStarred;

@end


@interface SSTask (CoreDataGeneratedAccessors)
- (void)addTaskSessionsObject:(SSTaskSession *)value;
- (void)removeTaskSessionsObject:(SSTaskSession *)value;
- (void)addTaskSessions:(NSSet *)value;
- (void)removeTaskSessions:(NSSet *)value;

@end


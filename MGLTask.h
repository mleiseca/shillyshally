//
//  MGLTask.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 3/5/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@class MGLProject;
@class MGLTaskSession;

@interface MGLTask :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * meeting;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * ticketId;
@property (nonatomic, retain) NSNumber * hoursEstimate;
@property (nonatomic, retain) MGLProject * project;
@property (nonatomic, retain) NSSet* taskSessions;

- (NSString *) timeWorked;
- (NSDate *) workStartDate;

@end


@interface MGLTask (CoreDataGeneratedAccessors)
- (void)addTaskSessionsObject:(MGLTaskSession *)value;
- (void)removeTaskSessionsObject:(MGLTaskSession *)value;
- (void)addTaskSessions:(NSSet *)value;
- (void)removeTaskSessions:(NSSet *)value;

@end


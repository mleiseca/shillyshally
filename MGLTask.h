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

@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * ticketId;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * hoursEstimate;
@property (nonatomic, retain) NSSet* taskSessions;
@property (nonatomic, retain) MGLProject * project;

@end


@interface MGLTask (CoreDataGeneratedAccessors)
- (void)addTaskSessionsObject:(MGLTaskSession *)value;
- (void)removeTaskSessionsObject:(MGLTaskSession *)value;
- (void)addTaskSessions:(NSSet *)value;
- (void)removeTaskSessions:(NSSet *)value;

@end


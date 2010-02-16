//
//  MGLTask.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/15/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface MGLTask :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * hoursEstimate;
@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSString * ticketId;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet* taskSessions;

@property (nonatomic, retain, readonly) NSDate * workStartDate;
@property (nonatomic, retain, readonly) NSNumber * secondsWorked;


@end


@interface MGLTask (CoreDataGeneratedAccessors)
- (void)addTaskSessionsObject:(NSManagedObject *)value;
- (void)removeTaskSessionsObject:(NSManagedObject *)value;
- (void)addTaskSessions:(NSSet *)value;
- (void)removeTaskSessions:(NSSet *)value;
- (NSString *) timeWorked;


@end


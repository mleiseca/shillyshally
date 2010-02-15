//
//  MGLTask.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface MGLTask :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * hoursEstimate;
@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSDate * workStartDate;
@property (nonatomic, retain) NSString * ticketId;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * secondsWorked;

@end




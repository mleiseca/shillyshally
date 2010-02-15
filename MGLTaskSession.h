//
//  MGLTaskSession.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/15/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@class MGLTask;

@interface MGLTaskSession :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * secondsWorked;
@property (nonatomic, retain) MGLTask * task;

@end




//
//  MGLTaskSession.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/15/10.
//  .
//

#import <CoreData/CoreData.h>

@class MGLTask;

@interface MGLTaskSession :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * secondsWorked;
@property (nonatomic, retain) MGLTask * task;
@property (nonatomic, retain) NSString * note;

@property (nonatomic, retain) NSString * timeWorked;

@end




//
//  SSReportsTimeSlice.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/9/10.
//  .
//

#import <Cocoa/Cocoa.h>


@interface SSTaskReport : NSObject {
	NSMutableArray *tasks;

}
- (id) initWithStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate;

@property (nonatomic, retain) NSMutableArray *tasks;

@end

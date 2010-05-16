//
//  SSReportsTimeSlice.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/9/10.
//  .
//

#import <Cocoa/Cocoa.h>


@interface SSTaskReport : NSObject {
	NSArray *matchingTasks;

}

@property (nonatomic, retain) NSArray *matchingTasks;

@end

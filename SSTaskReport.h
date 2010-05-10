//
//  SSReportsTimeSlice.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/9/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SSTaskReport : NSObject {
	NSArray *matchingTasks;

}

@property (nonatomic, retain) NSArray *matchingTasks;

@end

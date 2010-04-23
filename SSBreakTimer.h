//
//  SSBreakTimer.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/23/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSBreakTimer : NSObject {
	NSTimer *breakIntervalTimer;
	
	NSNumber *breakIntervalInSeconds;
	

}

@property (nonatomic, retain) NSTimer *breakIntervalTimer;
@property (nonatomic, copy) NSNumber *breakIntervalInSeconds;

@end

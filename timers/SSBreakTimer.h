//
//  SSBreakTimer.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/23/10.
//  .
//

#import <Foundation/Foundation.h>


@interface SSBreakTimer : NSObject {
	NSTimer *breakIntervalTimer;
	
	NSNumber *breakIntervalInSeconds;
	

}

@property (nonatomic, retain) NSTimer *breakIntervalTimer;
@property (nonatomic, copy) NSNumber *breakIntervalInSeconds;


- (id) initWithBreakIntervalInMinutes: (NSNumber *) interval;

@end

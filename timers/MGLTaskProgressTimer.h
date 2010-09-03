//
//  MGLTaskProgressTimer.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class SSTaskSession;

@interface MGLTaskProgressTimer : NSObject {
	SSTaskSession *activeTaskSession;
	NSDate *startDate;
	NSTimer *timer;
}

@property(nonatomic, retain) SSTaskSession *activeTaskSession;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) NSDate *startDate;


-(void) startTaskSession:(SSTaskSession *) task;
-(void) stopTask;
-(BOOL) isRunning;


@end

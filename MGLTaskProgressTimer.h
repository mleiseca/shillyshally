//
//  MGLTaskProgressTimer.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/14/10.
//  .
//

#import <Cocoa/Cocoa.h>

@class MGLTaskSession;

@interface MGLTaskProgressTimer : NSObject {
	MGLTaskSession *activeTaskSession;
	NSDate *startDate;
	NSTimer *timer;
}

@property(nonatomic, retain) MGLTaskSession *activeTaskSession;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) NSDate *startDate;


-(void) startTaskSession:(MGLTaskSession *) task;
-(void) stopTask;
-(BOOL) isRunning;


@end

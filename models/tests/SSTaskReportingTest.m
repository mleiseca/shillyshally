//
//  MGLTaskTest.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/14/10.
//  .
//

#import "SSFakeTask.h"
#import "SSFakeTaskSession.h"
#import "SSTask+Reporting.h"

#import "GTMSenTestCase.h"

@interface SSTaskReportingTest : GTMTestCase {
	
}


@end

@implementation SSTaskReportingTest

- (void) testSummingOfSecondsWorked{
	SSFakeTask *task = [[SSFakeTask alloc]init];
	
	SSFakeTaskSession *session1 = [[SSFakeTaskSession alloc] init];
	[session1 setSecondsWorked:[NSNumber numberWithInt:500]];
	
	SSFakeTaskSession *session2 = [[SSFakeTaskSession alloc] init];
	[session2 setSecondsWorked:[NSNumber numberWithInt:115]];

	
	task.taskSessions = [[NSSet alloc] initWithObjects: session1, session2, nil];
	
	STAssertEqualObjects([NSNumber numberWithInt:615], [task secondsWorked], @"Task should sum component session seconds worked");

	[task release];
	[session1 release];
	[session2 release];
}


@end

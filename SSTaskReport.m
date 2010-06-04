//
//  SSReportsTimeSlice.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/9/10.
//  .
//

#import "SSTaskReport.h"


@implementation SSTaskReport

@synthesize tasks;

- (id) initWithStartDate:(NSDate *)startDate withEndDate:(NSDate *)endDate
{
	
	if (self = [super init]){
		tasks = [[NSMutableArray alloc] init];
		
	}
	return self;
}

-(void)dealloc{
	[tasks release];
	
	[super dealloc];
}



@end

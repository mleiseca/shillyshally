// 
//  MGLTaskSession.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 2/15/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLTaskSession.h"

#import "MGLTask.h"

@implementation MGLTaskSession 

@dynamic createDate;
@dynamic secondsWorked;
@dynamic task;
@dynamic note;

- (void) awakeFromInsert
{
	//this is the only way I found to default the create date to current date on insert
	NSDate *now = [NSDate date];
	self.createDate = now;
}

- (NSString *) timeWorked{
	NSNumber *secondsWorked = [self secondsWorked];
	
	if(secondsWorked){
		int seconds = [secondsWorked intValue];
		
		return [NSString stringWithFormat:@"%d:%02d", (seconds/60), (seconds % 60)];
    }else{
		return @"";
    }
}

-(void) setTimeWorked:(NSString *) param{
	if(! param){		
		return;
	}
	
	NSLog(@"Setting timeworked with: %@", param);
	
	NSArray* components = [param componentsSeparatedByString:@":"];
	
	NSInteger newSecondsWorked;
	if([components count] == 1){
		int minutes = [[components objectAtIndex:0] integerValue];
		NSLog(@"found minutes : %d", minutes);
		
		newSecondsWorked = minutes * 60;
		
	}else if( [components count] == 2){
		
		int minutes = [[components objectAtIndex:0] integerValue];
		int seconds = [[components objectAtIndex:1] integerValue];
		
		NSLog(@"found time: min %d, sec %d" ,minutes, seconds);

		newSecondsWorked = (minutes * 60) + seconds;
	}else{
		//todo: what needs to happen here?
		NSLog(@"invalid value");
	}
	
	if(newSecondsWorked && (newSecondsWorked  > 0)){
		self.secondsWorked = [NSNumber numberWithInt:newSecondsWorked];
	}
}

+ (NSSet *)keyPathsForValuesAffectingTimeWorked{
	return [NSSet setWithObjects:@"secondsWorked", nil];
}


@end

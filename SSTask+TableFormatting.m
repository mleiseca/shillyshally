//
//  SSTask+TableFormatting.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.

//

#import "SSTask+TableFormatting.h"


@implementation SSTask (tableformatting)

+ (NSSet *)keyPathsForValuesAffectingFont{
	return [NSSet setWithObjects:@"running", nil];
}

+ (NSSet *)keyPathsForValuesAffectingColor{
	return [NSSet setWithObjects:@"running", nil];
}

- (NSFont *) font{
	if (running){
		return  [NSFont fontWithName:@"Lucida Grande Bold" size:13];
	}else{
		return [NSFont fontWithName:@"Lucida Grande" size:13];
	}
}


- (NSColor *) color{
	if (running){
		return [NSColor redColor];
	}else{
		return [NSColor blackColor];
	}
}

@end

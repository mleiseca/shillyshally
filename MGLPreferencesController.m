//
//  PreferencesController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/21/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import "MGLPreferencesController.h"


@implementation MGLPreferencesController

- (id) init {
	
	if (! [super initWithWindowNibName:@"Preferences"]){
		return nil;
	}
	
	return self;
}
@end

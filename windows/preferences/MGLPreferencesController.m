//
//  PreferencesController.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 4/21/10.
//  .
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

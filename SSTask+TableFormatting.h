//
//  SSTask+TableFormatting.h
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/16/10.
//  Copyright 2010 Grubhub Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGLTask.h"

@interface MGLTask (tableformatting)
- (NSFont *) font;
- (NSColor *) color;

@end

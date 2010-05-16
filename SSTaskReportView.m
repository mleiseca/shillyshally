//
//  SSSingleTaskView.m
//  WorkTimerWithPersistence
//
//  Created by Michael Leiseca on 5/10/10.
//  .
//

#import "SSTaskReportView.h"


@implementation SSTaskReportView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	NSGradient *backgroundGradient = [[NSGradient alloc] initWithStartingColor:[NSColor grayColor] endingColor:[NSColor blackColor]];
	[backgroundGradient drawInRect:dirtyRect angle:90];
	
	NSMutableDictionary *drawStringAttributes = [[NSMutableDictionary alloc] init];
	[drawStringAttributes setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	[drawStringAttributes setValue:[NSFont fontWithName:@"American Typewriter" size:24] forKey:NSFontAttributeName];
	NSShadow *stringShadow = [[NSShadow alloc] init];
	[stringShadow setShadowColor:[NSColor blackColor]];
	NSSize shadowSize;
	shadowSize.width = 2;
	shadowSize.height = -2;
	[stringShadow setShadowOffset:shadowSize];
	[stringShadow setShadowBlurRadius:6];
	[drawStringAttributes setValue:stringShadow forKey:NSShadowAttributeName];	
	[stringShadow release];
	
	NSString *MRString = @"Hello RaulAmor!";
	NSString *budgetString = [NSString stringWithFormat:@"%@", MRString];
	NSSize stringSize = [budgetString sizeWithAttributes:drawStringAttributes];
	NSPoint centerPoint;
	centerPoint.x = (dirtyRect.size.width / 2) - (stringSize.width / 2);
	centerPoint.y = dirtyRect.size.height / 2 - (stringSize.height / 2);
	[budgetString drawAtPoint:centerPoint withAttributes:drawStringAttributes];
	[drawStringAttributes release];
}

@end

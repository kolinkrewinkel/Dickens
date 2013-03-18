//
//  DickensTests.m
//  DickensTests
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "DickensTests.h"
#import "NSString+KKPolishing.h"

NSString *const DickensTestMessyString = @"This string contains \"dumb double quotes.\" As well, it has 'dumb single quotes.' This concludes the quote section... Here's a spaced hyphen - an interruption, per se. Also, a number range (1-4) and date range (1998-2013). Here's a sharp dash-no spaces at all.";
NSString *const DickensTestPolishedString = @"This string contains “dumb double quotes.” As well, it has ‘dumb single quotes.’ This concludes the quote section… Hereʼs a spaced hyphen – an interruption, per se. Also, a number range (1–4) and date range (1998–2013). Hereʼs a sharp dash—no spaces at all.";

@implementation DickensTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testPolish
{
    NSString *polishedString = DickensTestMessyString.polishedString;
    NSLog(@"Polished String: %@", polishedString);
    NSLog(@"    Goal String: %@", DickensTestPolishedString);
    STAssertTrue([polishedString isEqualToString:DickensTestPolishedString], @"Polish failed.");
}

@end

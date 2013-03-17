//
//  DickensTests.m
//  DickensTests
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "DickensTests.h"
#import "NSString+KKPolishing.h"

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
    NSString *unpolishedString = @"This string contains \"dumb quotes.\"";

    STAssertTrue([unpolishedString.polishedString isEqualToString:@"This string contains “dumb quotes.”"], @"Polish failed.");
}

@end

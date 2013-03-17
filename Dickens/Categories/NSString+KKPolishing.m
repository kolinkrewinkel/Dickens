//
//  NSString+ReplacementAdditions.m
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "NSString+KKPolishing.h"

@implementation NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)endToEndRange
{
    return NSMakeRange(0, self.length);
}

#pragma mark - Polish Methods

- (NSString *)grammaticallyPolishedString
{
    NSMutableString *grammaticallyPolishedString = self.mutableCopy;
    [grammaticallyPolishedString enumerateSubstringsInRange:self.endToEndRange options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        NSLog(@"%@", substring);
    }];

    return [[NSString alloc] initWithString:grammaticallyPolishedString];
}

@end

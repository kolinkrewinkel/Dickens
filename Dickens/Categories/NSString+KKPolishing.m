//
//  NSString+ReplacementAdditions.m
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "NSString+KKPolishing.h"

NSString * const KKPolishLeftDoubleQuote = @"“";
NSString * const KKPolishRightDoubleQuote = @"”";

NSString * const KKPolishDoubleQuoteExpression = @"\".*\"";

@implementation NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)endToEndRange
{
    return NSMakeRange(0, self.length);
}

#pragma mark - Polish Methods

- (NSString *)polishedString
{
    NSMutableString *grammaticallyPolishedString = self.mutableCopy;

    NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:KKPolishDoubleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil];

    for (NSTextCheckingResult *quoteResult in [expression matchesInString:self options:NSMatchingReportCompletion range:self.endToEndRange]) {
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[NSString stringWithFormat:@"%@%@%@", KKPolishLeftDoubleQuote, [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)], KKPolishRightDoubleQuote]];
    }

    return [[NSString alloc] initWithString:grammaticallyPolishedString];
}

@end

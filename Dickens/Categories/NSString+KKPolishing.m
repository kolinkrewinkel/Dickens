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
    return NSMakeRange(0, self.length); // The entire length of the string.
}

#pragma mark - Polish Methods

- (NSString *)polishedString
{
    // Make a copy to make mutating it easier.
    NSMutableString *grammaticallyPolishedString = self.mutableCopy;

#pragma mark • Double Quotes
    NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:KKPolishDoubleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    for (NSTextCheckingResult *quoteResult in [expression matchesInString:self options:NSMatchingReportCompletion range:self.endToEndRange]) {
        NSString *content = [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)];
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[self _wrapString:content withOpeningString:KKPolishLeftDoubleQuote closingString:KKPolishRightDoubleQuote]];
    }

    return [[NSString alloc] initWithString:grammaticallyPolishedString];
}

#pragma mark - Convenience Methods

- (NSString *)_wrapString:(NSString *)bodyString withOpeningString:(NSString *)openingString closingString:(NSString *)closingString
{
    return [[NSString alloc] initWithFormat:@"%@%@%@", openingString, bodyString, closingString];
}

@end

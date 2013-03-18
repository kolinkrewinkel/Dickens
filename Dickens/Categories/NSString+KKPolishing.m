//
//  NSString+ReplacementAdditions.m
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "NSString+KKPolishing.h"

#pragma mark - Double Quotes

NSString *const KKCharacterLeftDoubleQuotationMark = @"\u201c";
NSString *const KKCharacterRightDoubleQuotationMark = @"\u201d";
NSString *const KKPolishDoubleQuoteExpression = @"\".*\"";

#pragma mark - Single Quotes

NSString *const KKCharacterLeftSingleQuotationMark = @"\u2018";
NSString *const KKCharacterRightSingleQuotationMark = @"\u2019";
NSString *const KKPolishSingleQuoteExpression = @"'.*'";

#pragma mark - Ellipsis

NSString *const KKCharacterEllipsis = @"\u2026";
NSString *const KKPolishingEllipsisExpression = @"(...)(?!’|”|'|\")";

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

    // Single quotes.
    NSRegularExpression *singleQuoteExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishSingleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil]; // Dot matches line seperators to include quotes which include linebreaks.
    for (NSTextCheckingResult *quoteResult in [singleQuoteExpression matchesInString:self options:NSMatchingReportCompletion range:self.endToEndRange]) {
        NSString *content = [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)]; // Quoted content
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[self _wrapString:content withOpeningString:KKCharacterLeftSingleQuotationMark closingString:KKCharacterRightSingleQuotationMark]]; // Replace dumb single quotes.
    }

    // Double quotes.
    NSRegularExpression *doubleQuoteExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishDoubleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil]; // Dot matches line seperators to include quotes which include linebreaks.
    for (NSTextCheckingResult *quoteResult in [doubleQuoteExpression matchesInString:self options:NSMatchingReportCompletion range:self.endToEndRange]) {
        NSString *content = [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)]; // Quoted content
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[self _wrapString:content withOpeningString:KKCharacterLeftDoubleQuotationMark closingString:KKCharacterRightDoubleQuotationMark]]; // Replace dumb double quotes.
    }

    return [[NSString alloc] initWithString:grammaticallyPolishedString];
}

#pragma mark - Convenience Methods

- (NSString *)_wrapString:(NSString *)bodyString withOpeningString:(NSString *)openingString closingString:(NSString *)closingString
{
    return [[NSString alloc] initWithFormat:@"%@%@%@", openingString, bodyString, closingString];
}

@end

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
NSString *const KKPolishSingleQuoteExpression = @"(?<= )'.*?'";

#pragma mark - Ellipsis

NSString *const KKCharacterEllipsis = @"\u2026";
NSString *const KKPolishEllipsisExpression = @"\\.\\.\\.";

#pragma mark - Em Dash

NSString *const KKCharacterEmDash = @"\u2014";
NSString *const KKPolishEmDashExpression = @"((?<=\\w)|(?<=” ))(-{2,3})((?=\\w)|(?= [A-Z]))";

#pragma mark - En Dash

NSString *const KKCharacterEnDash = @"\u2013";
NSString *const KKPolishEnDashExpression = @"(?<=\\w )-(?= \\w)|(?<=[0-9])-(?=[0-9])"; // Captures word space hyphen space word, and numbers hyphen numbers.

#pragma mark - Apostrophe

NSString *const KKCharacterApostrophe = @"\u02bc";
NSString *const KKPolishApostropheExpression = @"(?<=\\w)'(?=\\w )";

#pragma mark - Implementation

@implementation NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)KK_endToEndRange
{
    return NSMakeRange(0, self.length); // The entire length of the string.
}

#pragma mark - Polish Methods

- (NSString *)KK_polishedString
{
    // Make a copy to make mutating it easier.
    NSMutableString *grammaticallyPolishedString = self.mutableCopy;

    [grammaticallyPolishedString replaceOccurrencesOfString:KKCharacterLeftDoubleQuotationMark withString:@"\"" options:0 range:self.KK_endToEndRange];
    [grammaticallyPolishedString replaceOccurrencesOfString:KKCharacterRightDoubleQuotationMark withString:@"\"" options:0 range:self.KK_endToEndRange];
    [grammaticallyPolishedString replaceOccurrencesOfString:KKCharacterLeftSingleQuotationMark withString:@"'" options:0 range:self.KK_endToEndRange];
    [grammaticallyPolishedString replaceOccurrencesOfString:KKCharacterRightSingleQuotationMark withString:@"'" options:0 range:self.KK_endToEndRange];
    [grammaticallyPolishedString replaceOccurrencesOfString:KKCharacterApostrophe withString:@"'" options:0 range:self.KK_endToEndRange];

    // Single quotes.
    NSRegularExpression *singleQuoteExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishSingleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil]; // Dot matches line seperators to include quotes which include linebreaks.

    for (NSTextCheckingResult *quoteResult in [singleQuoteExpression matchesInString:grammaticallyPolishedString options:NSMatchingReportCompletion range:grammaticallyPolishedString.KK_endToEndRange]) {
        NSString *content = [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)]; // Quoted content
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[self KK_wrapString:content withOpeningString:KKCharacterLeftSingleQuotationMark closingString:KKCharacterRightSingleQuotationMark]]; // Replace dumb single quotes.
    }

    // Double quotes.
    NSRegularExpression *doubleQuoteExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishDoubleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil]; // Dot matches line seperators to include quotes which include linebreaks.

    for (NSTextCheckingResult *quoteResult in [doubleQuoteExpression matchesInString:grammaticallyPolishedString options:NSMatchingReportCompletion range:grammaticallyPolishedString.KK_endToEndRange]) {
        NSString *content = [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)]; // Quoted content
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[self KK_wrapString:content withOpeningString:KKCharacterLeftDoubleQuotationMark closingString:KKCharacterRightDoubleQuotationMark]]; // Replace dumb double quotes.
    }

    // Ellipsis.
    NSRegularExpression *ellipsisExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishEllipsisExpression options:0 error:nil];
    NSUInteger charactersChanged = 0;

    for (NSTextCheckingResult *tripleDotResult in [ellipsisExpression matchesInString:grammaticallyPolishedString options:0 range:grammaticallyPolishedString.KK_endToEndRange]) {

        // Because we're actually mutating the string we used to find the ranges, we need to make sure that the ranges we use accumulate/are concious of the new positions.
        [grammaticallyPolishedString replaceCharactersInRange:NSMakeRange(tripleDotResult.range.location - charactersChanged, tripleDotResult.range.length) withString:KKCharacterEllipsis];

        // Increment! (... -> …)
        charactersChanged += tripleDotResult.range.length - KKCharacterEllipsis.length;
    }

    // Em dashes.
    NSRegularExpression *emDashExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishEmDashExpression options:0 error:nil];

    for (NSTextCheckingResult *hyphenResult in [emDashExpression matchesInString:grammaticallyPolishedString options:0 range:grammaticallyPolishedString.KK_endToEndRange]) {
        [grammaticallyPolishedString replaceCharactersInRange:hyphenResult.range withString:KKCharacterEmDash];
    }

    // En dashes.
    NSRegularExpression *enDashExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishEnDashExpression options:0 error:nil];

    charactersChanged = 0;
    for (NSTextCheckingResult *hyphenResult in [enDashExpression matchesInString:grammaticallyPolishedString options:0 range:grammaticallyPolishedString.KK_endToEndRange]) {
        [grammaticallyPolishedString replaceCharactersInRange:NSMakeRange(hyphenResult.range.location - charactersChanged, hyphenResult.range.length) withString:KKCharacterEnDash];
        charactersChanged += hyphenResult.range.length - KKCharacterEnDash.length;
    }
    
    // Apostrophes.
    NSRegularExpression *apostropheExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishApostropheExpression options:0 error:nil];

    for (NSTextCheckingResult *singleQuoteResult in [apostropheExpression matchesInString:grammaticallyPolishedString options:0 range:grammaticallyPolishedString.KK_endToEndRange]) {
        [grammaticallyPolishedString replaceCharactersInRange:singleQuoteResult.range withString:KKCharacterApostrophe];
    }

    return [[NSString alloc] initWithString:grammaticallyPolishedString];
}

#pragma mark - Convenience Methods

- (NSString *)KK_wrapString:(NSString *)bodyString withOpeningString:(NSString *)openingString closingString:(NSString *)closingString
{
    return [[NSString alloc] initWithFormat:@"%@%@%@", openingString, bodyString, closingString];
}

+ (dispatch_queue_t)KK_sharedPolishQueue
{
    static dispatch_queue_t sharedQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedQueue = dispatch_queue_create("com.kolinkrewinkel.dickens.stringProcessing", DISPATCH_QUEUE_SERIAL);
    });

    return sharedQueue;
}

@end

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

#pragma mark - Dictionary Constants

NSString *const KKOperatedString = @"KKOperatedString";
NSString *const KKSingleQuoteCorrections = @"KKSingleQuoteCorrections";
NSString *const KKDoubleQuoteCorrections = @"KKDoubleQuoteCorrections";
NSString *const KKEllipsisCorrections = @"KKEllipsisCorrections";
NSString *const KKEmDashCorrections = @"KKEmDashCorrections";
NSString *const KKEnDashCorrections = @"KKEnDashCorrections";
NSString *const KKApostropheCorrections = @"KKApostropheCorrections";

#pragma mark - Implementation

@implementation NSString (KKPolishing)

#pragma mark - Convenience

- (NSRange)KK_endToEndRange
{
    return NSMakeRange(0, self.length); // The entire length of the string.
}

- (NSMutableString *)KK_correctionRegressedMutableCopy
{
    NSMutableString *copy = self.mutableCopy;

    [copy replaceOccurrencesOfString:KKCharacterLeftDoubleQuotationMark withString:@"\"" options:0 range:self.KK_endToEndRange];
    [copy replaceOccurrencesOfString:KKCharacterRightDoubleQuotationMark withString:@"\"" options:0 range:self.KK_endToEndRange];
    [copy replaceOccurrencesOfString:KKCharacterLeftSingleQuotationMark withString:@"'" options:0 range:self.KK_endToEndRange];
    [copy replaceOccurrencesOfString:KKCharacterRightSingleQuotationMark withString:@"'" options:0 range:self.KK_endToEndRange];
    [copy replaceOccurrencesOfString:KKCharacterApostrophe withString:@"'" options:0 range:self.KK_endToEndRange];

    return copy;
}

#pragma mark - Polish Methods

- (NSDictionary *)KK_correctionTextCheckingResults
{
    // Make a copy to make mutating it easier.
    NSMutableString *string = [self KK_correctionRegressedMutableCopy];
    NSRange endToEndRange = [string KK_endToEndRange];

    NSMutableDictionary *textCheckingResults = [[NSMutableDictionary alloc] init];
    textCheckingResults[KKOperatedString] = string;

    // Single quotes.
    NSRegularExpression *singleQuoteExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishSingleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil]; // Dot matches line seperators to include quotes which include linebreaks.
    NSArray *singleQuoteMatches = [singleQuoteExpression matchesInString:string options:0 range:endToEndRange];
    if (singleQuoteMatches.count)
    {
        textCheckingResults[KKSingleQuoteCorrections] = singleQuoteMatches;
    }

    // Double quotes.
    NSRegularExpression *doubleQuoteExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishDoubleQuoteExpression options:NSRegularExpressionDotMatchesLineSeparators error:nil]; // Dot matches line seperators to include quotes which include linebreaks.
    NSArray *doubleQuoteMatches = [doubleQuoteExpression matchesInString:string options:0 range:endToEndRange];
    if (doubleQuoteMatches.count)
    {
        textCheckingResults[KKDoubleQuoteCorrections] = doubleQuoteMatches;
    }

    // Ellipsis.
    NSRegularExpression *ellipsisExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishEllipsisExpression options:0 error:nil];
    NSArray *ellipsisMatches = [ellipsisExpression matchesInString:string options:0 range:endToEndRange];
    if (ellipsisMatches.count)
    {
        textCheckingResults[KKEllipsisCorrections] = ellipsisMatches;
    }

    // Em dashes.
    NSRegularExpression *emDashExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishEmDashExpression options:0 error:nil];
    NSArray *emDashMatches = [emDashExpression matchesInString:string options:0 range:endToEndRange];
    if (emDashMatches.count)
    {
        textCheckingResults[KKEmDashCorrections] = emDashMatches;
    }

    // En dashes.
    NSRegularExpression *enDashExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishEnDashExpression options:0 error:nil];
    NSArray *enDashMatches = [enDashExpression matchesInString:string options:0 range:endToEndRange];
    if (enDashMatches.count)
    {
        textCheckingResults[KKEnDashCorrections] = enDashMatches;
    }

    // Apostrophes.
    NSRegularExpression *apostropheExpression = [[NSRegularExpression alloc] initWithPattern:KKPolishApostropheExpression options:0 error:nil];
    NSArray *apostropheMatches = [apostropheExpression matchesInString:string options:0 range:endToEndRange];
    if (apostropheMatches.count)
    {
        textCheckingResults[KKApostropheCorrections] = apostropheMatches;
    }

    return textCheckingResults;
}

- (NSString *)KK_polishedString
{
    NSDictionary *correctionTextCheckingResults = [self KK_correctionTextCheckingResults];
    NSMutableString *string = correctionTextCheckingResults[KKOperatedString];

    for (NSTextCheckingResult *quoteResult in correctionTextCheckingResults[KKSingleQuoteCorrections]) {
        NSString *content = [string substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)]; // Quoted content
        [string replaceCharactersInRange:quoteResult.range withString:[NSString KK_wrapString:content withOpeningString:KKCharacterLeftSingleQuotationMark closingString:KKCharacterRightSingleQuotationMark]]; // Replace dumb single quotes.
    }

    for (NSTextCheckingResult *quoteResult in correctionTextCheckingResults[KKDoubleQuoteCorrections]) {
        NSString *content = [string substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)]; // Quoted content
        [string replaceCharactersInRange:quoteResult.range withString:[NSString KK_wrapString:content withOpeningString:KKCharacterLeftDoubleQuotationMark closingString:KKCharacterRightDoubleQuotationMark]]; // Replace dumb double quotes.
    }

    NSInteger charactersChanged = 0;
    for (NSTextCheckingResult *tripleDotResult in correctionTextCheckingResults[KKEllipsisCorrections]) {

        // Because we're actually mutating the string we used to find the ranges, we need to make sure that the ranges we use accumulate/are concious of the new positions.
        [string replaceCharactersInRange:NSMakeRange(tripleDotResult.range.location - charactersChanged, tripleDotResult.range.length) withString:KKCharacterEllipsis];

        // Increment! (... -> …)
        charactersChanged += tripleDotResult.range.length - KKCharacterEllipsis.length;
    }

    for (NSTextCheckingResult *hyphenResult in correctionTextCheckingResults[KKEmDashCorrections]) {
        [string replaceCharactersInRange:hyphenResult.range withString:KKCharacterEmDash];
    }

    for (NSTextCheckingResult *hyphenResult in correctionTextCheckingResults[KKEnDashCorrections]) {
        [string replaceCharactersInRange:NSMakeRange(hyphenResult.range.location - charactersChanged, hyphenResult.range.length) withString:KKCharacterEnDash];
        charactersChanged += hyphenResult.range.length - KKCharacterEnDash.length;
    }

    for (NSTextCheckingResult *singleQuoteResult in correctionTextCheckingResults[KKApostropheCorrections]) {
        [string replaceCharactersInRange:singleQuoteResult.range withString:KKCharacterApostrophe];
    }

    return [[NSString alloc] initWithString:string];
}

#pragma mark - Convenience Methods

+ (NSString *)KK_wrapString:(NSString *)bodyString withOpeningString:(NSString *)openingString closingString:(NSString *)closingString
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

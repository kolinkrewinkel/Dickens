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

@implementation NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)endToEndRange
{
    return NSMakeRange(0, self.length);
}

#pragma mark - Polish Methods

- (void)polishString:(KKPolishingStringCompletionBlock)completionHandler
{
    NSMutableString *grammaticallyPolishedString = self.mutableCopy;

    NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:@"\".*\"" options:NSRegularExpressionDotMatchesLineSeparators error:nil];

    for (NSTextCheckingResult *quoteResult in [expression matchesInString:self options:NSMatchingReportCompletion range:self.endToEndRange]) {
        [grammaticallyPolishedString replaceCharactersInRange:quoteResult.range withString:[NSString stringWithFormat:@"%@%@%@", KKPolishLeftDoubleQuote, [grammaticallyPolishedString substringWithRange:NSMakeRange(quoteResult.range.location + 1, quoteResult.range.length - 2)], KKPolishRightDoubleQuote]];
    }

    NSLog(@"%@", grammaticallyPolishedString);

    completionHandler(grammaticallyPolishedString);
}

@end

//
//  NSString+KKPolishing.h
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

typedef void (^KKPolishingStringCompletionBlock)(NSString *polishedString);

extern NSString *const KKPolishLeftDoubleQuote;
extern NSString *const KKPolishRightDoubleQuote;

@interface NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)endToEndRange;

#pragma mark - Polish Methods

- (NSString *)polishedString;

@end

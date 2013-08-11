//
//  NSString+KKPolishing.h
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#pragma mark - Constants for nice characters. For your convenience.

extern NSString *const KKCharacterLeftDoubleQuotationMark;
extern NSString *const KKCharacterRightDoubleQuotationMark;

extern NSString *const KKCharacterLeftSingleQuotationMark;
extern NSString *const KKCharacterRightSingleQuotationMark;

extern NSString *const KKCharacterEmDash;
extern NSString *const KKCharacterEnDash;

extern NSString *const KKCharacterApostrophe;

#pragma mark - Dictionary Constants

extern NSString *const KKOperatedString;
extern NSString *const KKSingleQuoteCorrections;
extern NSString *const KKDoubleQuoteCorrections;
extern NSString *const KKEllipsisCorrections;
extern NSString *const KKEmDashCorrections;
extern NSString *const KKEnDashCorrections;
extern NSString *const KKApostropheCorrections;

@interface NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)KK_endToEndRange;

#pragma mark - Polish Methods

// Primary method. Put this on a queue for your users' sake.
- (NSString *)KK_polishedString;

// Takes the body and encloses it with the opening and closing string. Helpful with quotes.
- (NSString *)KK_wrapString:(NSString *)bodyString withOpeningString:(NSString *)openingString closingString:(NSString *)closingString;

#pragma mark - Helpers

+ (dispatch_queue_t)KK_sharedPolishQueue; // Returns a shared serial queue which prevents text from regressing. If you have a large volume of polishing from multiple text views happening simulataneously, it may be advantageous to instantiate your own serial queue for each, so they're not conflicting. For most, however, the single, shared queue will be enough, especially on iOS.


@end

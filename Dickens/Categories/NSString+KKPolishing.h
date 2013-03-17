//
//  NSString+KKPolishing.h
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

@interface NSString (KKPolishing)

#pragma mark - These should be in NSString by default.

- (NSRange)endToEndRange;

#pragma mark - Polish Methods

- (NSString *)grammaticallyPolishedString;

@end

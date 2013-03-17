//
//  NSString+ReplacementAdditions.m
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "NSString+KKPolishing.h"

@implementation NSString (KKPolishing)

#pragma mark - Polish Methods

- (NSString *)grammaticallyPolishedString
{
    NSMutableString *grammaticallyPolishedString = self.mutableCopy;
    

    return [[NSString alloc] initWithString:grammaticallyPolishedString];
}

@end

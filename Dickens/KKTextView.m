//
//  KKTextView.m
//  Dickens
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "KKTextView.h"
#import "NSString+KKPolishing.h"

@implementation KKTextView {
    dispatch_queue_t _polishQueue;
}

#pragma mark - Initializers

- (id)init
{
    if ((self = [super init])) {
        [self _commonInit];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self _commonInit];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self _commonInit];
    }

    return self;
}

#pragma mark - Shared Initialization

- (void)_commonInit
{
    _polishQueue = dispatch_queue_create("com.handcrafted.textView.polishing", DISPATCH_QUEUE_SERIAL);
    self.polishTextAutomatically = YES;
}

@end

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

    BOOL _shouldPolish; // One time polishing.
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
}

#pragma mark - Setters

- (void)setText:(NSString *)text polish:(BOOL)polish
{
    _shouldPolish = YES;
    self.text = text;
    _shouldPolish = NO;
}

- (void)setText:(NSString *)text
{
    [super setText:text];

    if (_shouldPolish || _polishTextAutomatically)
        dispatch_async(_polishQueue, ^{
            [super setText:text.polishedString];
        });
}

@end

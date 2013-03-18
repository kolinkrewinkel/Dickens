//
//  DKDAppDelegate.m
//  DickensDemo
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "DKDAppDelegate.h"
#import <Dickens/NSString+KKPolishing.h>

@implementation DKDAppDelegate {
    dispatch_queue_t _polishQueue;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UIViewController *viewController = [[UIViewController alloc] init];
    self.window.rootViewController = viewController;

    _polishQueue = dispatch_queue_create("com.handcrafted.DickensDemo.textProcessing", DISPATCH_QUEUE_SERIAL);

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.delegate = self;
    viewController.view = textView;

    [self.window makeKeyAndVisible];
    [textView becomeFirstResponder];

    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *textViewText = [textView.text stringByReplacingCharactersInRange:range withString:text];

    dispatch_async(_polishQueue, ^{
        NSString *refinedText = textViewText.polishedString;

        dispatch_async(dispatch_get_main_queue(), ^{
            textView.text = refinedText;
        });
    });

    return YES;
}

@end

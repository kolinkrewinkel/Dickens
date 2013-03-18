//
//  DKDAppDelegate.m
//  DickensDemo
//
//  Created by Kolin Krewinkel on 3/17/13.
//  Copyright (c) 2013 Handcrafted. All rights reserved.
//

#import "DKDAppDelegate.h"
#import <Dickens/KKTextView.h>

@implementation DKDAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UIViewController *viewController = [[UIViewController alloc] init];
    self.window.rootViewController = viewController;
    
    KKTextView *textView = [[KKTextView alloc] initWithFrame:viewController.view.bounds];
    textView.delegate = self;
    viewController.view = textView;

    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - UITextViewDelegate

@end

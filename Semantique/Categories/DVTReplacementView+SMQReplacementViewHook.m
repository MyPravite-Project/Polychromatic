//
//  DVTReplacementView+SMQReplacementViewHook.m
//  Semantique
//
//  Created by Kolin Krewinkel on 3/31/14.
//  Copyright (c) 2014 Kolin Krewinkel. All rights reserved.
//

#import "DVTReplacementView+SMQReplacementViewHook.h"
#import "SMQSwizzling.h"
#import "SMQThemePreferencesViewController.h"

static IMP SMQOriginalSetupImplementation;

@implementation DVTReplacementView (SMQReplacementViewHook)

#pragma mark - NSObject

+ (void)load
{
    SMQOriginalSetupImplementation = SMQPoseSwizzle(self, @selector(_setupViewController), self, @selector(smq_setupViewController), YES);
}

- (void)smq_setupViewController
{

    if ([self.controllerExtensionIdentifier isEqualToString:@"Xcode.PreferencePane.FontAndColor"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.controllerClass = [SMQThemePreferencesViewController class];
//            self.controllerClass = [NSClassFromString(@"IDEAlertsPrefsPaneController") class];
        });
        SMQOriginalSetupImplementation(self, @selector(_setupViewController));

    }
    else
    {
        SMQOriginalSetupImplementation(self, @selector(_setupViewController));

    }
}

@end
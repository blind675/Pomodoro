//
//  AppDelegate.m
//  Pomodoro
//
//  Created by Catalin BORA on 12/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "AppDelegate.h"
#import "StatisticsModel.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // define user interactions
    UIMutableUserNotificationAction *OKAction = [[UIMutableUserNotificationAction alloc] init];
    OKAction.identifier = kOKActionKey;
    OKAction.title = @"OK";
    OKAction.activationMode = UIUserNotificationActivationModeBackground;
    OKAction.authenticationRequired = false;
    OKAction.destructive = false;
    
    UIMutableUserNotificationAction *KeepGoingAction = [[UIMutableUserNotificationAction alloc] init];
    KeepGoingAction.identifier = kKeepGoingActionKey;
    KeepGoingAction.title = @"Keep going";
    KeepGoingAction.activationMode = UIUserNotificationActivationModeBackground;
    KeepGoingAction.authenticationRequired = false;
    KeepGoingAction.destructive = true;
    
    // 2. Create the category ***********************************************
    
    // Category
    UIMutableUserNotificationCategory *warningNotificationCategory = [[UIMutableUserNotificationCategory alloc] init];
    warningNotificationCategory.identifier = kWarningNotificationCategoryKey;
    [warningNotificationCategory setActions:@[OKAction,KeepGoingAction] forContext:UIUserNotificationActionContextDefault];
    
    // New for iOS 8 - Register the notifications
    UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:[NSSet setWithObject:kWarningNotificationCategoryKey]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [StatisticsModel changeDayIfNeede];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

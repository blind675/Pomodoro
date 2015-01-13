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
#import "NotificationManager.h"
#import "TimerManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // app doesen't have notification enabled
    if (![[NotificationManager sharedInstance] areNotificationsEnabledByTheUser]) {
        
        // 1. Create the actions **************************************************
        
        // OK Action
        UIMutableUserNotificationAction *OKAction = [[UIMutableUserNotificationAction alloc] init];
        OKAction.identifier = kOKActionKey;
        OKAction.title = @"OK";
        OKAction.activationMode = UIUserNotificationActivationModeBackground;
        OKAction.authenticationRequired = YES;
        OKAction.destructive = NO;
        
        // Continuie Action
        UIMutableUserNotificationAction *KeepGoingAction = [[UIMutableUserNotificationAction alloc] init];
        KeepGoingAction.identifier = kKeepGoingActionKey;
        KeepGoingAction.title = @"Keep Going";
        KeepGoingAction.activationMode = UIUserNotificationActivationModeBackground;
        KeepGoingAction.authenticationRequired = YES;
        KeepGoingAction.destructive = NO;
        
        // 2. Create the category ***********************************************
        
        // Category
        UIMutableUserNotificationCategory *warningNotificationCategory = [[UIMutableUserNotificationCategory alloc] init];
        warningNotificationCategory.identifier = kWarningNotificationCategoryKey;
        
        // A. Set actions for the default context
        [warningNotificationCategory setActions:@[OKAction,KeepGoingAction] forContext:UIUserNotificationActionContextDefault];
        // B. Set actions for the minimal context
        [warningNotificationCategory setActions:@[OKAction,KeepGoingAction] forContext:UIUserNotificationActionContextMinimal];
        
        NSSet *categories = [NSSet setWithObjects:warningNotificationCategory,nil];
        
        // 3. Notification Registration *****************************************
        
        // New for iOS 8 - Register the notifications
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSLog(@"Application Will Resign Active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"Application Did Enter Background");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationEnteredBackgroundKey object:self];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    NSLog(@"Application Will Enter Foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSLog(@"Application Did Become Active");
    
    unsigned short timeLeft = [[TimerManager sharedInstance] resetTheTimerStateAndReturnTheRemainingTimeToNextState];
    [StatisticsModel changeDayIfNeede];
    
    NSDictionary* userData = @{@"timeLeft": @(timeLeft)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationStartedKey object:self userInfo:userData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"Application Will Terminate");
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //TODO: just update the pomodoros
    
    NSLog(@" notification recived:%@",notification);
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification Received" message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    
    NSLog(@"AppDelegate - handleActionWithIdentifier: %@", identifier);
    
    //TODO: just update the pomodoros
    
    // clear notifications just to be shure
    ((NotificationManager *)[NotificationManager sharedInstance]).userPassedTheNormalTime = YES;
    [[NotificationManager sharedInstance] removeAllNotifications];
    
    if ([identifier isEqualToString:kOKActionKey]) {
        //handle OK action
        //do nothing else
        NSLog(@"User kOKActionKey the notification");
        
    } else if ([identifier isEqualToString:kKeepGoingActionKey]) {
        
        //TODO: schedule next notifications
        
        //handle Keep Going action
        NSLog(@"User kKeepGoingActionKey the notification");
    }
    
    //must call completion handler when finished
    completionHandler();

}

@end

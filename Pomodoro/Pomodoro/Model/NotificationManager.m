//
//  NotificationManager.m
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/15/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "NotificationManager.h"
#import "TimerModel.h"
#import "Constants.h"

#define kMaxWorkingHours 16
#define kWaningHours 10

@implementation NotificationManager

+ (id)sharedManager {
    static NotificationManager *sharedNotificationManager = nil;
    @synchronized(self) {
        if (sharedNotificationManager == nil){
            sharedNotificationManager = [[self alloc] init];
        }
    }
    return sharedNotificationManager;
}

#pragma mark - Notifications

- (BOOL)areNotificationsEnabledByTheUser {
    
    UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert ){
        return YES;
    }
    
    return NO;
}

- (void)removeNotificationsList {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)addNotificationsListWithRemainingTime:(unsigned short)remainingTime {
    
    if ([self areNotificationsEnabledByTheUser]) {
        
        // determine time and type untll the next notification
        
        /* determine place in the pomodoro sequence. A pomodoro sequence is:
         WorkingTime - ShortBreak - WorkingTime - ShortBreak - WorkingTime - ShortBreak - WorkingTime - LongBreak
         */
        
        // determine how many notifications until the warning hours mark
        
        // determine how many notifications until the max hour mark ??
        
        // create the notofications until the warning mark and schedule them
        
        // create an interactive notification and schedule it
        
        // create the rest of notifications ??
        
        
//        //triger notification if app not active
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        if (notification)
//        {
//            notification.alertBody = @"Pomodoro time ended. Take a break.";
//            notification.soundName = UILocalNotificationDefaultSoundName;
//        }
//        
//        // this will fire the notification right away
//        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:kActivateNotifications
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Settings", nil];
        [alert show];
    }

}

#pragma mark - Alert management

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked Settings button
    if (buttonIndex == 1) {
        // http://stackoverflow.com/questions/9092142/ios-uialertview-button-to-go-to-setting-app
        // TODO: test this on actual device
        NSURL*url=[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end

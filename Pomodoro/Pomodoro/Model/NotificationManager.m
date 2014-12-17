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
#import "StatisticsModel.h"

#define kMaxWorkingHours 12
#define kWaningHours 8

@interface NotificationManager() {
    NSMutableArray *nottificationsArray;
}
@end

@implementation NotificationManager

+ (id)sharedManager {
    static NotificationManager *sharedNotificationManager = nil;
    @synchronized(self) {
        if (sharedNotificationManager == nil){
            sharedNotificationManager = [[self alloc] init];
            sharedNotificationManager.userWantsToExtendTime = NO;
        }
    }
    return sharedNotificationManager;
}

#pragma mark - Notifications

- (BOOL)areNotificationsEnabledByTheUser {
    
    UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (grantedSettings.types & UIUserNotificationTypeSound ){
        return YES;
    }
    
    return NO;
}

- (void)removeNotificationsList {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)addNotificationsListWithRemainingTime:(unsigned short)remainingTime {
    
    if ([self areNotificationsEnabledByTheUser]) {
        
        int intervalPointerIndex = 0;
        NSString *nextNotificationText;
        NSArray *notificationsTextsArray = @[kWorkNotificationMessage,kShortBreakNotificationMessage,
                                        kWorkNotificationMessage,kShortBreakNotificationMessage,
                                        kWorkNotificationMessage,kShortBreakNotificationMessage,
                                        kWorkNotificationMessage,kLongBreakNotificationMessage];
        
        NSArray *durationArray = @[[NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel shortPauseTime]],
                                   [NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel shortPauseTime]],
                                   [NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel shortPauseTime]],
                                   [NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel longPauseTime]]];
        
        // determine how many notifications until the warning hours mark
        double timeLeftUntilWarning = kWaningHours * 60 * 60 - [StatisticsModel todaysPomodoro] * [TimerModel workingTime];
        int pomodorosLeftUntilWarning = timeLeftUntilWarning / [TimerModel workingTime];
        NSLog(@" time left until warning:%f = %d (pomodori)",timeLeftUntilWarning,pomodorosLeftUntilWarning);
        
        // determine how many notifications until the max hour mark ??
        double timeLeftUntilMaxWork = kMaxWorkingHours * 60 * 60 - [StatisticsModel todaysPomodoro] * [TimerModel workingTime];
        int pomodorosLeftUntilMaxWork = timeLeftUntilMaxWork / [TimerModel workingTime];
        NSLog(@" time left until Max :%f = %d (pomodori)",timeLeftUntilMaxWork,pomodorosLeftUntilMaxWork);
        
        
        NSLog(@"   - old date:%@ add time:%@",[NSDate date], [TimerModel stringTimeFormatForValue:remainingTime]);
        // determine time untll the next notification
        NSDate *nextNotificationTime = [[NSDate date] dateByAddingTimeInterval: remainingTime];
        
        //
        /* determine place in the pomodoro sequence. A pomodoro sequence is:
         WorkingTime - ShortBreak - WorkingTime - ShortBreak - WorkingTime - ShortBreak - WorkingTime - LongBreak
         */
        intervalPointerIndex = [StatisticsModel todaysPomodoro] % 4;
        if ([TimerModel currentTimingIntervalType] == WorkingTime) {
            intervalPointerIndex++;
        }
        
        nextNotificationText = notificationsTextsArray[intervalPointerIndex];
        NSLog(@"1. NOTIFICATION TO SCHEDULE: time: %@ message: -%@-",nextNotificationTime,nextNotificationText);
        
        // schedule notification
        UILocalNotification *nextNotification = [[UILocalNotification alloc] init];
        if (nextNotification)
        {
            nextNotification.alertBody = nextNotificationText;
            nextNotification.soundName = UILocalNotificationDefaultSoundName;
            nextNotification.fireDate = nextNotificationTime;
        }
        
//        [[UIApplication sharedApplication] presentLocalNotificationNow:nextNotification];
        [[UIApplication sharedApplication] scheduleLocalNotification:nextNotification];
 
        // create the notofications until the warning mark and schedule them
        for (int i = 1; i < pomodorosLeftUntilWarning * 2; i++) {
            
            NSLog(@"   - old date:%@ add time:%@",nextNotificationTime,[TimerModel stringTimeFormatForValue:[durationArray[intervalPointerIndex] unsignedShortValue]]);
            
            // increment the date
            nextNotificationTime = [nextNotificationTime dateByAddingTimeInterval:[durationArray[intervalPointerIndex] unsignedShortValue]];
            
            intervalPointerIndex++;
            if (intervalPointerIndex == 8) {
                intervalPointerIndex = 0;
            }
            
            nextNotificationText = notificationsTextsArray[intervalPointerIndex];
            NSLog(@"%d. NOTIFICATION TO SCHEDULE: time: %@ message: -%@-",i ,nextNotificationTime, nextNotificationText);
            
            // schedule notification
            nextNotification = [[UILocalNotification alloc] init];
            if (nextNotification)
            {
                nextNotification.alertBody = nextNotificationText;
                nextNotification.soundName = UILocalNotificationDefaultSoundName;
                nextNotification.fireDate = nextNotificationTime;
            }
            [[UIApplication sharedApplication] scheduleLocalNotification:nextNotification];
        }
        
        //create an interactive notification and schedule it
        
        // increment the date
        nextNotificationTime = [nextNotificationTime dateByAddingTimeInterval:[durationArray[intervalPointerIndex] unsignedShortValue]];
        
        intervalPointerIndex++;
        if (intervalPointerIndex == 8) {
            intervalPointerIndex = 0;
        }
        
        nextNotificationText = [NSString stringWithFormat:@"You have been working for more than %d hours. The pomodoro app will stop.",kWaningHours];
        NSLog(@"%d. NOTIFICATION TO SCHEDULE: time: %@ message: -%@-",pomodorosLeftUntilWarning * 2 ,nextNotificationTime, nextNotificationText);
        
        // schedule notification
        nextNotification = [[UILocalNotification alloc] init];
        if (nextNotification)
        {
            nextNotification.alertBody = nextNotificationText;
            nextNotification.soundName = UILocalNotificationDefaultSoundName;
            nextNotification.fireDate = nextNotificationTime;
            nextNotification.category = kWarningNotificationCategoryKey;
            
        }
//        [[UIApplication sharedApplication] presentLocalNotificationNow:nextNotification];
        [[UIApplication sharedApplication] scheduleLocalNotification:nextNotification];
        
        //TODO: create the rest of notifications ?? -- diferent methode
        
//
//        // calculate time spent so far
//        int numberOfIntervals = ([StatisticsModel todaysPomodoro] / 4);
//        // used time = pomodoro duration * numberOfPomodoros +
//        //             long break duration * (numberOfIntervals)       ( 1 long  break every interval ) +
//        //             short brak duration * (3 * numberOfIntervals)   ( 3 short breaks every interval) +
//        //             short brak duration * numberOfPomodoros % 4     ( remaining short breaks)
//        double timeUsedToday = [TimerModel workingTime] * [StatisticsModel todaysPomodoro] +
//                            [TimerModel longPauseTime] * numberOfIntervals +
//                            [TimerModel shortPauseTime] * ( 3 * numberOfIntervals )+
//                            [TimerModel shortPauseTime] * ([StatisticsModel todaysPomodoro] % 4);
//
//        NSLog(@" %d + %d + %d + %d", [TimerModel workingTime] * [StatisticsModel todaysPomodoro],
//              [TimerModel longPauseTime] * numberOfIntervals ,
//              [TimerModel shortPauseTime] * ( 3 * numberOfIntervals ),
//              [TimerModel shortPauseTime] * ([StatisticsModel todaysPomodoro] % 4));
//        
//        NSLog(@"Worked so far: %f",timeUsedToday);
        
        
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

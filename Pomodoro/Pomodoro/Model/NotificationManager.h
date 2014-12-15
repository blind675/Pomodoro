//
//  NotificationManager.h
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/15/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationManager : NSObject <UIAlertViewDelegate>

+(id)sharedManager;

- (void)addNotificationsListWithRemainingTime:(unsigned short)remainingTime;
- (void)removeNotificationsList;

@end

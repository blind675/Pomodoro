//
//  TimerManager.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "TimerManager.h"
#import "TimerModel.h"
#import "StatisticsModel.h"
#import <UIKit/UIKit.h>

@interface TimerManager() {
    unsigned short remainingTime;
}
@end

@implementation TimerManager

+ (id)sharedManager {
    static TimerManager *sharedTimerManager = nil;
    @synchronized(self) {
        if (sharedTimerManager == nil){
            sharedTimerManager = [[self alloc] init];
            //set the timer sate in the model to stop
            [TimerModel setCurrentTimerState:TimerStop];
        }
    }
    return sharedTimerManager;
}

-(unsigned short)startTimer {
    
    // this value will be returned
    unsigned short countDounValue;
    
    if ([TimerModel currentTimerState] == TimerStop) {
        countDounValue =[TimerModel workingTime];
        [TimerModel setCurrentTimingIntervalType:WorkingTime];
    } else {
        countDounValue = remainingTime;
    }
    
    [TimerModel setCurrentTimerState:TimerStart];
    
    return countDounValue;
}

-(void)pauseTimerAtValue:(unsigned short)countDownValue {
    remainingTime = countDownValue;
    [TimerModel setCurrentTimerState:TimerPause];
}

-(void)stopTimer {
    remainingTime = 0;
    [TimerModel setCurrentTimerState:TimerStop];
}

-(unsigned short)moveToTheNextIntervalType {
    
    //TODO: cleanup the code
    if ([TimerModel currentTimingIntervalType] == WorkingTime) {
        
        //triger notification if app not active
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification)
        {
            notification.alertBody = @"Pomodoro time ended. Take a break.";
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        
        // this will fire the notification right away
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        
        [StatisticsModel incrementTodaysPomodoro];
        
        if (!([StatisticsModel todaysPomodoro] % 4)) {
            [TimerModel setCurrentTimingIntervalType:LongPause];
            return [TimerModel longPauseTime];
        } else {
            [TimerModel setCurrentTimingIntervalType:ShortPause];
            return [TimerModel shortPauseTime];
        }
    } else {
        
        //triger notification if app not active
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification)
        {
            notification.alertBody = @"Break over. Back to work.";
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        
        // this will fire the notification right away
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        
        [TimerModel setCurrentTimingIntervalType:WorkingTime];
        return [TimerModel workingTime];
    }
    
}

@end

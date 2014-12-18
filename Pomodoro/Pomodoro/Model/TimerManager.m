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
#import "NotificationManager.h"

@interface TimerManager() {
    unsigned short remainingTime;
}
@end

@implementation TimerManager

+ (id)sharedInstance {
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
        countDounValue = [TimerModel workingTime];
        [TimerModel setCurrentTimingIntervalType:WorkingTime];
    } else {
        countDounValue = remainingTime;
    }
    
    [TimerModel setCurrentTimerState:TimerStart];
    
    [[NotificationManager sharedInstance] addNotificationsListWithRemainingTime:countDounValue];
    
    return countDounValue;
}

-(void)pauseTimerAtValue:(unsigned short)countDownValue {
    remainingTime = countDownValue;
    [TimerModel setCurrentTimerState:TimerPause];
    
    [[NotificationManager sharedInstance] removeAllNotifications];
}

-(void)stopTimer {
    remainingTime = 0;
    [TimerModel setCurrentTimerState:TimerStop];
    
    [[NotificationManager sharedInstance] removeAllNotifications];
}

-(unsigned short)moveToTheNextIntervalType {
    
    NSLog(@" -- Pomodoro moved to the next step. Pomodoro done Today:%d" ,[StatisticsModel todaysPomodoro]);
    
    if ([TimerModel currentTimingIntervalType] == WorkingTime) {
        
        [StatisticsModel incrementTodaysPomodoro];
        if (!([StatisticsModel todaysPomodoro] % 4)) {
            [TimerModel setCurrentTimingIntervalType:LongPause];
            return [TimerModel longPauseTime];
        } else {
            [TimerModel setCurrentTimingIntervalType:ShortPause];
            return [TimerModel shortPauseTime];
        }
    } else {
        
        [TimerModel setCurrentTimingIntervalType:WorkingTime];
        return [TimerModel workingTime];
    }
    
}

@end

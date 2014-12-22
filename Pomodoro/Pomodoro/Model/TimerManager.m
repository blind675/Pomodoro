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
#import "Constants.h"

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
    
//    [[NotificationManager sharedInstance] addNotificationsListWithRemainingTime:countDounValue];
    
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


-(unsigned short)resetTheTimerStateAndReturnTheRemainingTimeToNextState {
    
    // read internal timer state
    NSDate *lastTimestamp = [[NSUserDefaults standardUserDefaults] objectForKey:kLastTimeAppEnteredBackgroundTimestampKey];
    double secondsTillNow = abs([lastTimestamp timeIntervalSinceNow]);
    
    long timeLeft = [[NSUserDefaults standardUserDefaults] integerForKey:kTimeLeftUntilNextStateKey];
    long lastStateValue = [[NSUserDefaults standardUserDefaults] integerForKey:kTimerStateAtBackgroundEntryKey];
    long lastIntervalTypeValue = [[NSUserDefaults standardUserDefaults] integerForKey:kTimerIntervalTypeAtBackgroundEntryKey];
    
    NSLog(@" last timestamp:%@",lastTimestamp);
    NSLog(@" time left:%ld",timeLeft);
    NSLog(@" seconds since the app entered background:%f",secondsTillNow);
    NSLog(@" last state:%ld",lastStateValue);
    NSLog(@" last interval type:%ld",lastIntervalTypeValue);
    
    if (lastStateValue == TimerStart) {
        // no stage change or anything
        if (secondsTillNow < remainingTime) {
            return remainingTime - secondsTillNow;
        } else {
            
            NSArray *durationArray = @[[NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel shortPauseTime]],
                                       [NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel shortPauseTime]],
                                       [NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel shortPauseTime]],
                                       [NSNumber numberWithUnsignedShort:[TimerModel workingTime]],[NSNumber numberWithUnsignedShort:[TimerModel longPauseTime]]];
            
            /* determine place in the pomodoro sequence. A pomodoro sequence is:
             WorkingTime - ShortBreak - WorkingTime - ShortBreak - WorkingTime - ShortBreak - WorkingTime - LongBreak
             */
            int intervalPointerIndex = [StatisticsModel todaysPomodoro] % 4;
            if (lastIntervalTypeValue != WorkingTime) {
                intervalPointerIndex++;
            }
            
            double remainingTimeUntilNext = 0;
            
            while (secondsTillNow > 0) {
                
                remainingTimeUntilNext = secondsTillNow ;
                
                intervalPointerIndex++;
                if (intervalPointerIndex == 8) {
                    intervalPointerIndex = 0;
                }
                secondsTillNow -= [durationArray[intervalPointerIndex] unsignedShortValue];
            }
            
            NSLog(@" remaining time from interval:%f",remainingTimeUntilNext);
            
            //TODO: find the interval type and set it
        }
    }
    
    // if the last state was stoped of pause do nothing
    

    return 0;
}
@end

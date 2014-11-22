//
//  TimerManager.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "TimerManager.h"
#import "TimerModel.h"

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
        countDounValue = 60 * [TimerModel workingTime];
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
    
    switch ([TimerModel currentTimingIntervalType]) {
        case WorkingTime:
            //TODO: triger notification if app not active
            [TimerModel setCurrentTimingIntervalType:ShortPause];
            return 60 * [TimerModel shortPauseTime];
            break;
        case ShortPause:
            //TODO: triger notification if app not active
            [TimerModel setCurrentTimingIntervalType:LongPause];
            return 60 * [TimerModel longPauseTime];
            break;
        case LongPause:
            //TODO: triger notification if app not active
            [TimerModel setCurrentTimingIntervalType:WorkingTime];
            return 60 * [TimerModel workingTime];
            break;
        default:
            return 0;
            break;
    }

}

@end

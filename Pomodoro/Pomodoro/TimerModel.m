//
//  TimerModel.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "TimerModel.h"

@implementation TimerModel

static TimerState currentState = TimerStop;
static IntervalType intervalType;

+(TimerState)currentTimerState{
    return currentState;
}
+(void)setCurrentTimerState:(TimerState)newState{
    currentState = newState;
}
+(IntervalType)currentTimingIntervalType{
    return intervalType;
}
+(void)setCurrentTimingIntervalType:(IntervalType)newType{
    intervalType = newType;
}

// TODO: unhardcode
+(short)workingTime{
    return 25;
}
+(short)shortPauseTime{
    return 5;
}
+(short)longPauseTime{
    return 15;
}

@end
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
+(unsigned short)workingTime{
    return 1500; // = 25 min
}

+(unsigned short)shortPauseTime{
    return 300; // = 5 min
}

+(unsigned short)longPauseTime{
    return 900; // = 15 min
}

#pragma mark - Tools

+(NSString*)stringTimeFormatForValue:(unsigned short)countDownValue {

    // devide the countDownValue by 60 but to get the quotient and remainder
    // but do it objective c way
    div_t divresult;
    divresult = div (countDownValue,60);

    return [NSString stringWithFormat:@"%02d:%02d",divresult.quot,divresult.rem];
}

@end
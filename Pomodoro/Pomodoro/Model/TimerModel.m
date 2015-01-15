//
//  TimerModel.m
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "TimerModel.h"
#import "Constants.h"

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

+(unsigned short)workingTime{
    
    unsigned short value = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kWorkingTimeKey];
    if (value == 0) {
        // 1500 = 25 min
//        return 1500;
        return 180;
    } else {
        return value;
    }
}

+(unsigned short)shortPauseTime{
    
    unsigned short value = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kShortPauseTimeKey];
    if (value == 0) {
        //  300 =  5 min
//        return 300;
        return 100;
    } else {
        return value;
    }
}

+(unsigned short)longPauseTime{
    
    unsigned short value = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kLongPauseTimeKey];
    if (value == 0) {
        //  900 = 15 min
//        return 900;
        return 135;
    } else {
        return value;
    }
}

#pragma mark - Tools

+(NSString*)stringTimeFormatForValue:(unsigned short)countDownValue {

    // devide the countDownValue by 60 but to get the quotient and remainder
    // but do it objective c way
    div_t divResult;
    divResult = div (countDownValue,60);

    if (divResult.quot > 59) {
        div_t secondResult = div (divResult.quot,60);
        return [NSString stringWithFormat:@"%d:%02d:%02d",secondResult.quot,secondResult.rem,divResult.rem];
    } else {
        return [NSString stringWithFormat:@"%02d:%02d",divResult.quot,divResult.rem];
    }
}

@end
//
//  TimerModel.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerModel : NSObject

typedef enum {
    TimerStart,
    TimerPause,
    TimerStop,
} TimerState ;

typedef enum {
    WorkingTime,
    ShortPause,
    LongPause,
} IntervalType;

+(TimerState)currentTimerState;
+(void)setCurrentTimerState:(TimerState)newState;
+(IntervalType)currentTimingIntervalType;
+(void)setCurrentTimingIntervalType:(IntervalType)newType;
+(short)workingTime;
+(short)shortPauseTime;
+(short)longPauseTime;

@end

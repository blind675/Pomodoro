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
    TimerStart = 1,
    TimerPause = 2,
    TimerStop = 3,
} TimerState ;

typedef enum {
    WorkingTime = 11,
    ShortPause = 22,
    LongPause = 33,
} IntervalType;

+(TimerState)currentTimerState;
+(void)setCurrentTimerState:(TimerState)newState;
+(IntervalType)currentTimingIntervalType;
+(void)setCurrentTimingIntervalType:(IntervalType)newType;
+(unsigned short)workingTime;
+(unsigned short)shortPauseTime;
+(unsigned short)longPauseTime;
+(NSString*)stringTimeFormatForValue:(unsigned short)countDownValue;

@end

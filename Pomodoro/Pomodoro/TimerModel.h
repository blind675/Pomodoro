//
//  TimerModel.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWorkingTimeKey @"workingTimeKey"
#define kShortPauseTimeKey @"shortPauseTimeKey"
#define kLongPauseTimeKey @"longPauseTimeKey"

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
+(unsigned short)workingTime;
+(unsigned short)shortPauseTime;
+(unsigned short)longPauseTime;
+(NSString*)stringTimeFormatForValue:(unsigned short)countDownValue;

@end

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
    NSTimer *timer;
    NSTimer *shortPauseTimer;
    NSTimer *longPauseTimer;
}
@end

@implementation TimerManager

+ (id)sharedManager {
    static TimerManager *sharedTimerManager = nil;
    @synchronized(self) {
        if (sharedTimerManager == nil)
            sharedTimerManager = [[self alloc] init];
    }
    return sharedTimerManager;
}

-(void)startTimer{
}

-(void)pauseTimer{
}

-(void)stopTimer{
}

@end

//
//  TimerManager.h
//  Pomodoro
//
//  Created by Catalin BORA on 15/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerManager : NSObject

+(id)sharedManager;

-(unsigned short)startTimer;
-(void)pauseTimerAtValue:(unsigned short)countDownValue;
-(void)stopTimer;
-(unsigned short)moveToTheNextIntervalType;

@end

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

-(void)startTimer;
-(void)pauseTimer;
-(void)stopTimer;

@end

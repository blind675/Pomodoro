//
//  StatisticsModel.h
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/10/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticsModel : NSObject

+(unsigned short)todaysPomodoro;
+(void)incrementTodaysPomodoro;
+(void)resetTodaysPomodoro;

+(unsigned short)last7DaysAvg;

+(unsigned short)maxPomodoro;

+(unsigned short)yesterdayPomodoro;

+(void)changeDayIfNeede;

// used for tests
+(NSDate *)todayTestValue;
+(void)setTodayTestValue:(NSDate *)date ;

@end

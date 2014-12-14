//
//  StatisticsModel.m
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/10/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "StatisticsModel.h"
#import "Constants.h"
#import "NSDate+Yesterday.h"

@implementation StatisticsModel

static unsigned short lastDaysAvg;

// this is used for tests
static BOOL isYesterdayTestValue;

+(BOOL)isYesterdayTestValue {
    return isYesterdayTestValue;
}

+(void)setIsYesterdayTestValue:(BOOL)value {
    isYesterdayTestValue = value;
}

// this is where the test part ends

+(unsigned short)todaysPomodoro {
    return (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kTodaysPomodoroKey];
}

+(void)incrementTodaysPomodoro {
    unsigned short todaysPomodoro = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kTodaysPomodoroKey];
    todaysPomodoro++;
    [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kTodaysPomodoroKey];
    
    // also increment the max value if neede
    if (todaysPomodoro > (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kMaximumPomodoroKey]) {
        [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kMaximumPomodoroKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)resetTodaysPomodoro {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kTodaysPomodoroKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(unsigned short)averagePomodoro {
    NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kLastDaysKey]] ;
    
    int numberOfWorkedDays=0;
    int sume = 0;
    
    if (last7DaysValues) {
        for( NSNumber *dayValue in last7DaysValues) {
            numberOfWorkedDays++;
            sume += dayValue.shortValue;
        }
        
        return lastDaysAvg = sume / numberOfWorkedDays ;
    } else {
        return 0;
    }
    
}

+(unsigned short)maxPomodoro {
    return (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kMaximumPomodoroKey];
}

+(unsigned short)yesterdayPomodoro {
    return (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kYesterdayPomodoroKey];
}

+(void)changeDayIfNeede {
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:kLastOpeningTimestampKey];
    NSLog(@" last open date:%@",date);
    
    // get todays value
    unsigned short todaysPomodoro = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kTodaysPomodoroKey];
    
    if (isYesterdayTestValue || [date isYesterday]) {
        NSLog(@" the day changed");
        
        // set yesterday value
        [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kYesterdayPomodoroKey];
        
        // get the avg array
        NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kLastDaysKey]];
        
        if (last7DaysValues) {
            NSMutableArray *localArray = [[NSMutableArray alloc] initWithArray:last7DaysValues];
            [localArray addObject:[NSNumber numberWithUnsignedShort:todaysPomodoro]];
            last7DaysValues = [localArray copy];
        } else {
            last7DaysValues = @[[NSNumber numberWithUnsignedShort:todaysPomodoro]];
        }
        
        // save the array
        [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:last7DaysValues] forKey:kLastDaysKey];
        
        // reset today counter
        [self resetTodaysPomodoro];
        
    } 
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kLastOpeningTimestampKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

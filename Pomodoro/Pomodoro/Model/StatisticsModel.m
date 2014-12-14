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
static NSDate *todayTestValue;

+(NSDate *)todayTestValue {

    if (todayTestValue) {
        return todayTestValue;
    } else {
        return [NSDate date];
    }
}

+(void)setTodayTestValue:(NSDate *)date{
    todayTestValue = date;
}

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

+(unsigned short)last7DaysAvg {
    NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kLastDaysKey]] ;
    
    int numberOfWorkedDays=1;
    int sume = 0;
    
    if (last7DaysValues) {
        for( NSNumber *dayValue in last7DaysValues) {
            numberOfWorkedDays++;
            sume += dayValue.shortValue;
        }
    }
    
    sume += (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kTodaysPomodoroKey];;
    lastDaysAvg = sume / numberOfWorkedDays ;
    
    return lastDaysAvg;
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
    
    if ([date isYesterday]) {
        NSLog(@" the day changed");
        
        // set yesterday value
        [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kYesterdayPomodoroKey];
        
        // get the avg array
        NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kLastDaysKey]];
        
        if (last7DaysValues) {
            NSMutableArray *localArray;
            if ([last7DaysValues count] < 5) {
                localArray = [[NSMutableArray alloc] initWithArray:last7DaysValues];
                [localArray addObject:[NSNumber numberWithUnsignedShort:todaysPomodoro]];
            } else {
                localArray = [[NSMutableArray alloc] init];
                for (int i = 1; i < last7DaysValues.count; i++) {
                    [localArray addObject:last7DaysValues[i]];
                }
                [localArray addObject:[NSNumber numberWithUnsignedShort:todaysPomodoro]];
            }
            
            last7DaysValues = [localArray copy];
            
        } else {
            last7DaysValues = @[[NSNumber numberWithUnsignedShort:todaysPomodoro]];
        }
        
        // save the array
        [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:last7DaysValues] forKey:kLastDaysKey];
        
        // reset today counter
        [self resetTodaysPomodoro];
        
    } else if ( [date isMoreThanOneDayInThePast]) {

        NSArray *last7DaysValues = @[[NSNumber numberWithUnsignedShort:todaysPomodoro]];
        
        // save the array
        [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:last7DaysValues] forKey:kLastDaysKey];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[self todayTestValue] forKey:kLastOpeningTimestampKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

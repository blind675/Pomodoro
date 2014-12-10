//
//  StatisticsModel.m
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/10/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "StatisticsModel.h"
#import "Constants.h"

@implementation StatisticsModel

static unsigned short lastDaysAvg;
//static NSDate *todayFirstOpeningTimestamp;

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
    
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:kTodayFirstOpeningTimestampKey];
    
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate new]];
    NSDate* todayDate = [calendar dateFromComponents:components];

    NSLog(@" - date:%@ - today:%@",date ,todayDate);
    
    if ([date compare:todayDate] == NSOrderedDescending) {
        NSLog(@" the day changed");
        
        // get todays value
        unsigned short todaysPomodoro = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kTodaysPomodoroKey];
        
        // set yesterday value
        [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kYesterdayPomodoroKey];
        
        // get the avg array
        NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kLastDaysKey]];
        
        if (last7DaysValues) {
            //TODO: left here;
            NSMutableArray *localArray;
            //= [[NSMutableArray alloc] ];
            
        } else {
            last7DaysValues = @[[NSNumber numberWithUnsignedShort:todaysPomodoro]];
            // save the array
            [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:last7DaysValues] forKey:kLastDaysKey];
        }
        
        // set the new date
        [[NSUserDefaults standardUserDefaults] setObject:todayDate forKey:kTodayFirstOpeningTimestampKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:todayDate forKey:kTodayFirstOpeningTimestampKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

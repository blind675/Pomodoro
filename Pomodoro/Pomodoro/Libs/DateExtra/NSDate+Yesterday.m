//
//  NSDate+Yesterday.m
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import "NSDate+Yesterday.h"

@implementation NSDate (NSDate_Yesterday)

-(BOOL)isYesterday {
    
    NSDate *yesterday = [[NSDate date] dateByAddingTimeInterval: - 60*60*24];
    
    NSDateComponents *yesterdayDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:yesterday];
    NSDateComponents *selfDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    if([yesterdayDay day] == [selfDay day] && [yesterdayDay month] == [selfDay month] && [yesterdayDay year] == [selfDay year] && [yesterdayDay era] == [selfDay era]) {
        
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)isMoreThanOneDayInThePast {
    
    NSDate *yesterday = [[NSDate date] dateByAddingTimeInterval: - 60*60*24];
    
    NSDateComponents *yesterdayDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:yesterday];
    NSDateComponents *selfDay = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    
    
    if ( [yesterdayDay era] > [selfDay era] ||
        ([yesterdayDay era] == [selfDay era] && [yesterdayDay year] >  [selfDay year]) ||
        ([yesterdayDay era] == [selfDay era] && [yesterdayDay year] == [selfDay year] && [yesterdayDay month] >  [selfDay month]) ||
        ([yesterdayDay era] == [selfDay era] && [yesterdayDay year] == [selfDay year] && [yesterdayDay month] == [selfDay month] && [yesterdayDay day] > [selfDay day])) {
        
        return YES;
    } else {
        return NO;
    }
}

@end

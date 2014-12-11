//
//  NSDate+Yesterday.h
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSDate (NSDate_Yesterday)

-(BOOL)isYesterday;

-(BOOL)isMoreThanOneDayInThePast;

@end

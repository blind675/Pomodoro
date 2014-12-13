//
//  StatisticsModelTests.m
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "StatisticsModel.h"
#import "Constants.h"

@interface StatisticsModelTests : XCTestCase

@end

@implementation StatisticsModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kMaximumPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kYesterdayPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kTodaysPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastDaysKey];
    //found a way to do cleanup
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kMaximumPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kYesterdayPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kTodaysPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastDaysKey];
    //found a way to do cleanup
    
    [super tearDown];
}

- (void)testBasicOneDayStatisticsTest {

    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 0. Check Simulator if empty");
    XCTAssertEqual(0, [StatisticsModel yesterdayPomodoro], @" Yesterday Pomodoro not 0.");
    XCTAssertEqual(0, [StatisticsModel maxPomodoro], @" Max Pomodoro not 0.");
    XCTAssertEqual(0, [StatisticsModel last7DaysAvg], @" Last 7 Days Avg, Pomodoro not 0.");
    
    // increment today pomodoro
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    XCTAssertEqual(2, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 2. IncrementTodaysPomodoro not working");
    XCTAssertEqual(2, [StatisticsModel maxPomodoro], @" Max Pomodoro not 2. MaxPomodoro not working");
    XCTAssertEqual(2, [StatisticsModel last7DaysAvg], @" Last 7 Days Avg. Pomodoro not 2. Last 7 Days Avg. not working");
    
    // reset pomodoro
    [StatisticsModel resetTodaysPomodoro];
    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 1. resetTodaysPomodoro not working");
    XCTAssertEqual(2, [StatisticsModel maxPomodoro], @" Max Pomodoro not 1. MaxPomodoro not working");
    XCTAssertEqual(0, [StatisticsModel last7DaysAvg], @" Last 7 Days Avg. Pomodoro not 2. Last 7 Days Avg. not working");
    
}

- (void)testPassingOfDays {
    //TODO: write a test for this
    // also change StatisticsModel so i can simulate passing of days
}


//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end

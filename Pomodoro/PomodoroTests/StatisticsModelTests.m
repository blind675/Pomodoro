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
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastOpeningTimestampKey];
    //found a way to do cleanup
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kMaximumPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kYesterdayPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kTodaysPomodoroKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastDaysKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLastOpeningTimestampKey];
    //found a way to do cleanup
    
    [super tearDown];
}

- (void)testBasicOneDayStatisticsTest {

    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 0. Check Simulator if empty");
    XCTAssertEqual(0, [StatisticsModel yesterdayPomodoro], @" Yesterday Pomodoro not 0.");
    XCTAssertEqual(0, [StatisticsModel maxPomodoro], @" Max Pomodoro not 0.");
    XCTAssertEqual(0, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 0.");
    
    // increment today pomodoro
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    XCTAssertEqual(2, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 2. IncrementTodaysPomodoro not working");
    XCTAssertEqual(2, [StatisticsModel maxPomodoro], @" Max Pomodoro not 2. MaxPomodoro not working");
    XCTAssertEqual(0, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 0. Avg. Pomodoro not working");
    
    // reset pomodoro
    [StatisticsModel resetTodaysPomodoro];
    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 1. resetTodaysPomodoro not working");
    XCTAssertEqual(2, [StatisticsModel maxPomodoro], @" Max Pomodoro not 1. MaxPomodoro not working");
    XCTAssertEqual(0, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 0. Avg. Pomodoro not working");
    
}

- (void)testPassingOfDays {

    int numberOfDaysInThePast;
    
    // move 10 days in the past for bouth dates
    numberOfDaysInThePast = 10;
    
    //call the day changed methode
    [StatisticsModel changeDayIfNeede];
    
    // test if all is 0
    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 0. Check Simulator if empty");
    XCTAssertEqual(0, [StatisticsModel yesterdayPomodoro], @" Yesterday Pomodoro not 0.");
    XCTAssertEqual(0, [StatisticsModel maxPomodoro], @" Max Pomodoro not 0.");
    XCTAssertEqual(0, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 0.");
    
    // increment todays pomodori 5 times
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    
    // call the day changed methode again 9 days in the past
    numberOfDaysInThePast = 9;
    [StatisticsModel setIsYesterdayTestValue:YES];
    
    [StatisticsModel changeDayIfNeede];
    
    // check if the day change correctly
    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 0. Check Simulator if empty");
    XCTAssertEqual(5, [StatisticsModel yesterdayPomodoro], @" Yesterday Pomodoro not 5.");
    XCTAssertEqual(5, [StatisticsModel maxPomodoro], @" Max Pomodoro not 5.");
    XCTAssertEqual(5, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 5.");
    
    // call the day change again and test if things are the same
    [StatisticsModel setIsYesterdayTestValue:NO]; // same day
    [StatisticsModel changeDayIfNeede];
    
    // check if the day change correctly
    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 0. Check Simulator if empty");
    XCTAssertEqual(5, [StatisticsModel yesterdayPomodoro], @" Yesterday Pomodoro not 5.");
    XCTAssertEqual(5, [StatisticsModel maxPomodoro], @" Max Pomodoro not 5.");
    XCTAssertEqual(5, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 5.");
    
    
    // increment todays pomodoro 4 times
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    [StatisticsModel incrementTodaysPomodoro];
    
    // call the day changed methode again 8 days in the past
    numberOfDaysInThePast = 8;
    [StatisticsModel setIsYesterdayTestValue:YES];
    
    [StatisticsModel changeDayIfNeede];
    
    // check if the day change correctly
    XCTAssertEqual(0, [StatisticsModel todaysPomodoro], @" Today Pomodoro not 0. Check Simulator if empty");
    XCTAssertEqual(3, [StatisticsModel yesterdayPomodoro], @" Yesterday Pomodoro not 3.");
    XCTAssertEqual(5, [StatisticsModel maxPomodoro], @" Max Pomodoro not 5.");
    XCTAssertEqual(4, [StatisticsModel averagePomodoro], @" Avg. Pomodoro not 4.");
    
}

@end

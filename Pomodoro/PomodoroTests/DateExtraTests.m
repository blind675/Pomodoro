//
//  DateExtraTests.m
//  Pomodoro
//
//  Created by Catalin-Andrei BORA on 12/11/14.
//  Copyright (c) 2014 BobDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDate+Yesterday.h"

@interface DateExtraTests : XCTestCase

@end

@implementation DateExtraTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSDateIsYesterday {
   
    NSDate *today = [NSDate date];
    
    XCTAssert(![today isYesterday],@"Today is not Yesterday!");
    
    int numberOfDaysInThePast = 2;
    // this date is 2 days in the past
    NSDate *dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];
    
    XCTAssert(![dateInThePast isYesterday],@"Passed but the date diference is 2 days - date:%@ today:%@",dateInThePast,today );
    
    // move the today pointer to 1 day in the future
    numberOfDaysInThePast = -1 ;
    dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];

    XCTAssert(![dateInThePast isYesterday],@"Passed but the date is in the furute - date:%@ today:%@",dateInThePast,today );
    
    // move the today pointer to 1 day in the past
    numberOfDaysInThePast = 1 ;
    dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];
    
    XCTAssert([dateInThePast isYesterday],@"Methode should return YES but failed - date:%@ today:%@",dateInThePast,today );

}

-(void)testNSDateIsMoreThanOneDayInThePast {
    
    NSDate *today = [NSDate date];
    
    
    XCTAssert(![today isYesterday],@"Today is not Yesterday!");
    
    int numberOfDaysInThePast = 1;
    // this date is 1 days in the past
    NSDate *dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];
    
    XCTAssert(![dateInThePast isMoreThanOneDayInThePast],@"Passed but the date diference is 1 days - date:%@ today:%@",dateInThePast,today );
    
    // move the today pointer to 1 day in the future
    numberOfDaysInThePast = -1 ;
    dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];
    
    XCTAssert(![dateInThePast isMoreThanOneDayInThePast],@"Passed but the date is in the furute - date:%@ today:%@",dateInThePast,today );
    
    // move the today pointer to 2 days in the past
    numberOfDaysInThePast = 2 ;
    dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];
    
    XCTAssert([dateInThePast isMoreThanOneDayInThePast],@"Methode should return YES but failed - 2 days diference - date:%@ today:%@",dateInThePast,today );
    
    // move the today pointer to 5 days in the past
    numberOfDaysInThePast = 5 ;
    dateInThePast = [today dateByAddingTimeInterval: -60*60*24*numberOfDaysInThePast];
    
    XCTAssert([dateInThePast isMoreThanOneDayInThePast],@"Methode should return YES but failed - 5 days diference - date:%@ today:%@",dateInThePast,today );
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end

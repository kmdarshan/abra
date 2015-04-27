//
//  AbraCodeChallengeTests.m
//  AbraCodeChallengeTests
//
//  Created by Kateryna Sytnyk on 2/19/15.
//  Copyright (c) 2015 Abra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDate+Utils.h"
@interface AbraCodeChallengeTests : XCTestCase

@end

@implementation AbraCodeChallengeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testDate {
    NSString *testDateInGMT = @"2015-02-19 21:54:06 GMT";
    NSDate *gmtDate = [NSDate new];
    gmtDate = [gmtDate toDateFromString:testDateInGMT];
    XCTAssert(gmtDate!=nil, @"Pass");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

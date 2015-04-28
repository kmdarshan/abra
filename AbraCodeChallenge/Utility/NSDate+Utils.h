//
//  RRDateUtils.h
//  RoundRobin
//
//  Created by kmd on 12/21/14.
//  Copyright (c) 2014 Happy Days. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
-(NSDate*) toLocalTime;
-(NSDate*) toGlobalTime;
-(NSDate*) toDateFromString:(NSString*)datePosted;
@end

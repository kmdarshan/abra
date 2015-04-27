//
//  RRDateUtils.m
//  RoundRobin
//
//  Created by kmd on 12/21/14.
//  Copyright (c) 2014 Happy Days. All rights reserved.
//

#import "NSDate+Utils.h"
#import "RRHelper.h"
@implementation NSDate (Utils)
-(NSDate *) toLocalTime
{
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

-(NSDate *) toGlobalTime
{
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = -[tz secondsFromGMTForDate: self];
    return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}
-(NSDate*) toDateFromString:(NSString*)datePosted {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:kDateFormat];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSLocale* posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.locale = posix;
    NSDate *gmtDate = [dateFormatter dateFromString:datePosted];
    return [gmtDate toLocalTime];
}
@end

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
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    return [formatter stringFromDate:self];
}
- (NSString *) longString {
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString {
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString {
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}
- (NSString *) shortTimeString {
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString {
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}
@end

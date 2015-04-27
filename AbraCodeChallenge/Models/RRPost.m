//
//  RRPost.m
//  AbraCodeChallenge
//
//  Created by darshan on 4/22/15.
//  Copyright (c) 2015 Abra. All rights reserved.
//

#import "RRPost.h"
#import <MediaRSSParser/MediaRSSParser.h>
#import "RRHelper.h"
#import "NSDate+Utils.h"
@implementation RRPost
-(void)parseResponse:(NSDictionary *)response {
    if([response objectForKey:@"title"] != (id)[NSNull null])
    {
        self.name = [response objectForKey:@"title"];
    }
    if([response objectForKey:@"caption"] != (id)[NSNull null])
    {
        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        self.caption = [[[response objectForKey:@"caption"] stringByConvertingHTMLToPlainText] stringByTrimmingCharactersInSet:charSet];
    }
    if ([response objectForKey:@"date"] != (id)[NSNull null]) {
        NSDate *gmtDate = [NSDate new];
        [gmtDate toDateFromString:[response objectForKey:@"date"]];
        ([gmtDate toDateFromString:[response objectForKey:@"date"]] != nil ? (self.datePosted = [gmtDate toDateFromString:[response objectForKey:@"date"]]) : (self.datePosted = nil));
    }
    if([response objectForKey:@"photos"] != (id)[NSNull null])
    {
        NSArray *photos = [response objectForKey:@"photos"];
        if([photos count]>0){
            NSDictionary *photosDictionary = [photos objectAtIndex:0];
            if([photosDictionary objectForKey:@"alt_sizes"] != (id)[NSNull null]){
                NSArray *altsizes = [photosDictionary objectForKey:@"alt_sizes"];
                NSInteger random = arc4random_uniform((int)altsizes.count-1);
                // assuming the height and width must be less than 250
                // and there should be a image less than 250px
                // this is just my assumption here
                if (altsizes.count>0) {
                    NSDictionary *specs = [altsizes objectAtIndex:random];
                    BOOL bSatisfy = NO;
                    do {
                        if ([specs objectForKey:@"width"] != (id)[NSNull null]) {
                            if ([[specs objectForKey:@"width"] integerValue] < 275) {
                                bSatisfy = YES;
                                if ([specs objectForKey:@"url"] != (id)[NSNull null]) {
                                    self.imageUrl = [NSURL URLWithString:[specs objectForKey:@"url"]];
                                }else{
                                    self.imageUrl = nil;
                                }
                            } else {
                                // try another random
                                random = arc4random_uniform((int)altsizes.count-1);
                                specs = [altsizes objectAtIndex:random];
                            }
                        }
                    }while (!bSatisfy);
                }
            }
        }
    }
}
@end

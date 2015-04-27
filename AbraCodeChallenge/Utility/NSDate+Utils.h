//
//  RRDateUtils.h
//  RoundRobin
//
//  Created by kmd on 12/21/14.
//  Copyright (c) 2014 Happy Days. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)
-(NSDate *) toLocalTime;
-(NSDate *) toGlobalTime;
-(NSDate*) toDateFromString:(NSString*)datePosted;
@end

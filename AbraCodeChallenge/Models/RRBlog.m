//
//  RRBlog.m
//  AbraCodeChallenge
//
//  Created by darshan on 4/22/15.
//  Copyright (c) 2015 Abra. All rights reserved.
//

#import "RRBlog.h"

@implementation RRBlog
-(void)parseResponse:(NSDictionary *)response {
    if([response objectForKey:@"title"] != (id)[NSNull null])
    {
        self.title = [response objectForKey:@"title"];
    }
    if([response objectForKey:@"updated"] != (id)[NSNull null])
    {
        self.updated = [response objectForKey:@"updated"];
    }
    if([response objectForKey:@"posts"] != (id)[NSNull null])
    {
        self.posts = [[response objectForKey:@"posts"] integerValue];
    }

}
@end

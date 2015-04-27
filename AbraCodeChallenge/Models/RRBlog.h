//
//  RRBlog.h
//  AbraCodeChallenge
//
//  Created by darshan on 4/22/15.
//  Copyright (c) 2015 Abra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRBlog : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic) NSInteger posts;
-(void)parseResponse:(NSDictionary*)response;
@end

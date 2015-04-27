//
//  RRPost.h
//  AbraCodeChallenge
//
//  Created by darshan on 4/22/15.
//  Copyright (c) 2015 Abra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRPost : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSURL *imageUrl;
@property (nonatomic, copy) NSDate *datePosted;
-(void)parseResponse:(NSDictionary*)response;
@end

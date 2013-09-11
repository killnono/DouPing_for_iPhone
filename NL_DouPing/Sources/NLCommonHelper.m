//
//  NLCommonHelper.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLCommonHelper.h"

@implementation NLCommonHelper


+(NSString*)timeFormat:(NSString*)time
{
    NSRange r = [time rangeOfString:@"+"];
    if (r.length > 0) {
        time = [time substringToIndex:r.location];
    }
    
    time = [time stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
    return time;
}

@end

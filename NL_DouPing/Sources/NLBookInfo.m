//
//  NLBookInfo.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLBookInfo.h"

@implementation NLBookInfo
@synthesize url,image,title,author,summary;
- (void)dealloc
{
    [url release];
    [image release];
    [title release];
    [summary release];
    [author release];
    [super dealloc];
}
@end

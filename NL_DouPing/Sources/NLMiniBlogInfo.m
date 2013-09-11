//
//  NLMiniBlogInfo.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMiniBlogInfo.h"
@implementation NLMiniBlogInfo

@synthesize title,category,miniID,publishedTime,content,userName;

- (void)dealloc
{
    [title release];
    [category release];
    [miniID release];
    [publishedTime release];
    [content release];
    [userName release];
    [super dealloc];
}
@end

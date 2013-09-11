//
//  NLRssInfo.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-2.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLRssInfo.h"

@implementation NLRssInfo
@synthesize reViewId,title,pubDate,description,dc_creator,img,link;

- (void)dealloc
{
    [img release];
    [link release];
    [reViewId release];
    [dc_creator release];
    [title release];
    [pubDate release];
    [description release];
    [super dealloc];
}

@end

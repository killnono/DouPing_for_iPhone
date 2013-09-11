//
//  NLMusicInfo.m
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-13.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMusicInfo.h"

@implementation NLMusicInfo
@synthesize author,cast,image,title,url;
- (void)dealloc
{
    [author release];
    [cast release];
    [image release];
    [title release];
    [url release];
    [super dealloc];
}
@end

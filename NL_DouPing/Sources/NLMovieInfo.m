//
//  NLMovieInfo.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMovieInfo.h"

@implementation NLMovieInfo
@synthesize url,image,title,author,cast;
- (void)dealloc
{
    [url release];
    [image release];
    [title release];
    [cast release];
    [author release];
    [super dealloc];
}
@end

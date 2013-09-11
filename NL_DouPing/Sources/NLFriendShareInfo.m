//
//  NLFriendShareInfo.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-9.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLFriendShareInfo.h"

@implementation NLFriendShareInfo
@synthesize userName,metaDes,text,type,title,uerImage,metaTitle;
- (void)dealloc
{
    [userName release];
    [metaTitle release];
    [metaDes release];
    [text release];
    [type release];
    [title release];
    [uerImage release];
    [super dealloc];
}
@end

//
//  NLFriendsShuoInfo.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-10.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLFriendsShuoInfo.h"

@implementation NLFriendsShuoInfo
@synthesize text,title,content,username,shuoshuoID,short_title,created_time,userImageLink;
- (void)dealloc
{
    [text release];
    [title release];
    [content release];
    [userImageLink release];
    [username release];
    [shuoshuoID release];
    [short_title release];
    [created_time release];
    [super dealloc];
}
@end

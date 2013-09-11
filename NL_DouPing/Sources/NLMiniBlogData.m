//
//  NLMiniBlogData.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMiniBlogData.h"
#import "NLModelObject.h"
#import "JSON.h"
#import "NLMiniBlogInfo.h"
@implementation NLMiniBlogData
@synthesize userId,arrInfo;
- (void)dealloc
{
    
    [UIScreen instanceMethodForSelector:@selector(currentMode)] ;

    [userId release];
    [arrInfo release];
    [super dealloc];
}

- (void)jsonString2Bean:(NSString *)jsonString
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    self.arrInfo = a;
    [a release];
    
    NSMutableDictionary *dic = [jsonString JSONValue];  
    NSMutableArray *arr = [dic objectForKey:@"entry"];//获取数组实体
    NSString * name = [dic objectForKey:@"name"];
    
    for (id o in arr) {
        NSString *title = [[o objectForKey:@"title"] objectForKey:@"$t"];
        NSString *time = [[o objectForKey:@"published"] objectForKey:@"$t"];
        NSString *uuid = [[o objectForKey:@"id"] objectForKey:@"$t"];
    
        NLMiniBlogInfo *info = [[[NLMiniBlogInfo alloc] init] autorelease];
        info.title = title;
        info.publishedTime = time;
        info.miniID = uuid;
        info.userName = name;
        
        [self.arrInfo addObject:info];
    }
    
    
}
@end

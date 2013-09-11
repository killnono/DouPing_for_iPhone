//
//  NLFriendsShareData.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-9.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLFriendsShareData.h"
#import "NLModelObject.h"
#import "JSON.h"
#import "NLFriendShareInfo.h"
@implementation NLFriendsShareData
@synthesize count,start,arrInfo;
- (void)dealloc
{
    [arrInfo release];
    [count release];
    [start release];
    [super dealloc];
}

-(void)jsonString2Bean:(NSString *)jsonString
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    self.arrInfo = a;
    [a release];
    NSMutableArray *arr = [jsonString JSONValue];//获取数组实体
    
    for (id o in arr) {
        NSString *title = [o objectForKey:@"title"];//推荐，再看，听~~
        
        NSRange range = [title rangeOfString:@"[score]"];
        
        if (range.length > 0) {
            title = [title substringToIndex:range.location];
        }
        
        
        
        NSString *userImage = [[o objectForKey:@"user"] objectForKey:@"small_avatar"]; 
        NSString *userName = [[o objectForKey:@"user"] objectForKey:@"screen_name"]; 
        NSString *text = [o objectForKey:@"text"];
        
        

        NSArray *attachments = [o objectForKey:@"attachments"]; 
        if (attachments.count <1 ) 
            continue;
        NSMutableDictionary *meta = [attachments objectAtIndex:0];  
        NSString *type = [meta objectForKey:@"type"];

        NSString * metaTitle = [meta objectForKey:@"title"];//资讯title
        
        NSString * metaDesc = [meta objectForKey:@"description"];//描述
        
        NLFriendShareInfo *info = [[NLFriendShareInfo alloc] init] ;
        info.title = title;
        info.userName = userName;
        info.uerImage = userImage;
        info.metaDes = metaDesc;
        info.metaTitle = metaTitle;
        info.type = type;
        info.text = text;
        [self.arrInfo addObject:info];
        [info release];
    }

}
@end

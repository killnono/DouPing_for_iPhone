//
//  NLFriendsShuoShuoData.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-9.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLFriendsShuoShuoData.h"
#import "NLModelObject.h"
#import "JSON.h"
#import "NLFriendsShuoInfo.h"
@implementation NLFriendsShuoShuoData
@synthesize userId,arrInfo;
- (void)dealloc
{
    [userId release];
    [arrInfo release];
    [super dealloc];
}

- (void)jsonString2Bean:(NSString *)jsonString
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    self.arrInfo = a;
    [a release];
    NSArray *entryArr = [jsonString JSONValue];  
    if (entryArr && ![entryArr isEqual:[NSNull null]]) {
        
        for (id o in entryArr) {
//            NSString *object_kind = [o objectForKey:@"object_kind"];

            NSString *text = [o objectForKey:@"text"];
            NSString *screen_name = [[o objectForKey:@"user"] objectForKey:@"screen_name"];
            NSString *image = [[o objectForKey:@"user"] objectForKey:@"small_avatar"];
//            NSString *userid = [[o objectForKey:@"user"] objectForKey:@"userid"];
            
            
            //关于内容
            NSArray *attachmentsArr = [o objectForKey:@"attachments"];
            
            if ([attachmentsArr isEqual: [NSNull null]] || attachmentsArr.count < 1) {
                continue;
            }
            NSDictionary *firstDic = [attachmentsArr objectAtIndex:0];
            NSString *description = [firstDic objectForKey:@"description"];//描述
            NSString *title = [firstDic objectForKey:@"title"];//标题
            NSString *short_title = [o objectForKey:@"short_title"];//比如，写了新日记，推荐照片
            
            NLFriendsShuoInfo *info = [[[NLFriendsShuoInfo alloc] init]autorelease];
            info.username = screen_name;
            info.userImageLink = image;
            info.text = text;
            info.title = title;
            info.content = description;
            info.short_title = short_title;
            
            [arrInfo addObject:info];
            
        }
        
        
    }
        
}
@end

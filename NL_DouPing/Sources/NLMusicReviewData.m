//
//  NLMusicReviewData.m
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-13.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMusicReviewData.h"
#import "JSON.h"
#import "NLModelObject.h"
@implementation NLMusicReviewData
@synthesize tags,garde,title,author,summary,imageURl,pubTime,urlID;
- (void)dealloc
{
    [pubTime release];
    [tags release];
    [garde release];
    [author release];
    [summary release];
    [imageURl release];
    [urlID release];
    [super dealloc];
}
//判断string中是否有中文
- (BOOL)isDigitalOrAlpha : (NSString *) text {
    for (int i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        if (!isascii(uc)) {
            return NO;
        }
    }
    return YES;
}
- (void)jsonString2Bean:(NSString *)jsonString
{
    
    NSMutableDictionary *dic = [jsonString JSONValue];
    
    
    //评分
    id av = (NSString*)[[dic objectForKey:@"rating"] objectForKey:@"average"];
    if (![av isKindOfClass:[NSString class]]) {
        NSNumber *ns = [[NSNumber alloc] init];
        ns = av;
        
        self.garde = [NSString stringWithFormat:@"%.1f", [ns doubleValue]];
    }else {
        self.garde = av;
    }
    
    
    //标题
    NSString *ti = [dic objectForKey:@"title"];
    NSString *a_title = [dic objectForKey:@"alt_title"];
    if ([self isDigitalOrAlpha:ti]) {
        ti = a_title;
    }
    self.title =ti;
    
    
    //作者
    NSArray *au= [dic objectForKey:@"author"];
    NSMutableString *as = [[[NSMutableString alloc] initWithCapacity:0]autorelease];
    if (au.count >0) {
        for (id s in au) {
            [as appendString:[s objectForKey:@"name"]];
            [as appendString:@"/"];
        }
    }
    NSString *as1 = @"";
    if (as.length !=0) {
        as1 = [as substringToIndex:([as length]-1)];
    }
    self.author = as1.length > 0? as1:@"无";

    
    NSArray *a= [[dic objectForKey:@"attrs"] objectForKey:@"publisher"];
    
    NSMutableString *ps = [[[NSMutableString alloc] initWithCapacity:0] autorelease];
    if (a.count > 0) {
        for (NSString *s in a) {
            [ps appendString:s];
            [ps appendString:@"/"];
        }
    }
    
    NSArray *pArr= [[dic objectForKey:@"attrs"] objectForKey:@"pubdate"];
    if (pArr.count > 0) {
        for (NSString *s in pArr) {
            [ps appendString:s];
            [ps appendString:@"/"];
        }
    }

    NSString *a2 = @"";
    if (ps.length !=0) {
        a2 = [ps substringToIndex:([ps length]-1)];
    }
    self.pubTime = a2.length>0?a2:@"无";
    
    
    
    NSArray *tagArr = [dic objectForKey:@"tags"];
    NSMutableString *tg = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;

    if (tagArr.count >0) {
        for (id t in tagArr) {
            [tg appendString:[t objectForKey:@"name"]];
            [tg appendString:@"  "];
        }
    }
    
    self.tags = tg.length >0? tg:@"无信息";
    //描述
    self.summary = [dic objectForKey:@"summary"];
    
    //图片地址
    self.imageURl = [dic objectForKey:@"image"];
    
    //id
    self.urlID = [dic objectForKey:@"id"];
  
}

@end

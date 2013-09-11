//
//  NLBookReview.m
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-13.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLBookReview.h"
#import "NLModelObject.h"
#import "JSON.h"
@implementation NLBookReview
@synthesize author_intro,garde,title,author,summary,imageURl,pubTime,urlID;
- (void)dealloc
{
    [pubTime release];
    [author_intro release];
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
            [as appendString:s];
            [as appendString:@"/"];
        }
    }
    NSString *as1 = @"";
    if (as.length !=0) {
        as1 = [as substringToIndex:([as length]-1)];
    }
    self.author = as1;
    
    
    

    self.pubTime = [NSString stringWithFormat:@"%@  %@",[dic objectForKey:@"pubdate"],[dic objectForKey:@"price"]];
    
    
    //作者简介
    NSString *ai =  [dic objectForKey:@"author_intro"];
    self.author_intro = ai.length >0 ? ai:@"无记录";
    
    //描述
    self.summary = [dic objectForKey:@"summary"];
    
    //图片地址
    self.imageURl = [dic objectForKey:@"image"];
    
    //id
    self.urlID = [dic objectForKey:@"id"];
//    NSString *http = [dic objectForKey:@"mobile_link"];
//    NSArray *arrid = [http componentsSeparatedByString:@"/"];
//    if (arrid.count>=7) {
//        self.urlID = [arrid objectAtIndex:5];
//    }
}
@end

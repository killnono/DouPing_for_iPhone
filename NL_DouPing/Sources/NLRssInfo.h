//
//  NLRssInfo.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-2.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLRssInfo : NSObject
{
    NSString *title ;
    NSString *reViewId;
    NSString *description;
    NSString *content_encoded;
    NSString *dc_creator;
    NSString *pubDate;
    NSString *img;
    NSString *link;

    
}
@property(retain,nonatomic)NSString *title ;
@property(retain,nonatomic) NSString *reViewId;
@property(retain,nonatomic) NSString *description;
@property(retain,nonatomic)  NSString *pubDate;
@property(retain,nonatomic)  NSString *dc_creator;
@property(retain,nonatomic)  NSString *img;
@property(retain,nonatomic) NSString *link;

@end

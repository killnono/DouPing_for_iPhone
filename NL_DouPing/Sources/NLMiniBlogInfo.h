//
//  NLMiniBlogInfo.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLMiniBlogInfo : NSObject

@property(retain,nonatomic)NSString *category;//类别说说，book，recommendation，event
@property(retain,nonatomic)NSString *title;//说说的标题
@property(retain,nonatomic)NSString *content;//说说的内容
@property(retain,nonatomic)NSString *publishedTime;//时间
@property(retain,nonatomic)NSString *miniID;//id
@property(retain,nonatomic)NSString *userName;//id



@end

////类型
//@interface Category : NSObject
//@property(retain,nonatomic)NSString *scheme;
//@property(retain,nonatomic)NSString *term;
//@end

//@interface Link : NSObject
//@property(retain,nonatomic)NSString *rel;
//@property(retain,nonatomic)NSString *term;
//@end

//@interface Published : NSObject
//@property(retain,nonatomic)NSString *time;
//@property(retain,nonatomic)NSString *term;

//
//  NLMusicReviewData.h
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-13.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLMusicReviewData : NSObject
@property(retain,nonatomic)NSString *garde;//评分
@property(retain,nonatomic)NSString *imageURl;//图片
@property(retain,nonatomic)NSString *author;//作者
@property(retain,nonatomic)NSString *summary;//描述
@property(retain,nonatomic)NSString *tags;//作者信息
@property(retain,nonatomic)NSString *title;//标题
@property(retain,nonatomic)NSString *pubTime;
@property(retain,nonatomic)NSString *urlID;//链接地址
@end

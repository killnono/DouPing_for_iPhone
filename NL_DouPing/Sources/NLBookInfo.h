//
//  NLBookInfo.h
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NLBookInfo : NSObject
@property(retain,nonatomic)NSString *title ;
@property(retain,nonatomic) NSString *url;
@property(retain,nonatomic) NSString *image;
@property(retain,nonatomic)  NSString *author;
@property(retain,nonatomic)  NSString *summary;

@end

//
//  NLSearchObject.h
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLSearchObject : NSObject
@property(retain,nonatomic)NSString *_tag;

@property(retain,nonatomic)NSString *totals;
@property(retain,nonatomic)NSMutableArray *arrInfo;
@end

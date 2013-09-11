//
//  NLRSSData.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-3.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NLRssInfo.h"
@interface NLRSSData : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *parserObjects;
    NSMutableDictionary *twitterDic;
     NSMutableString *currentText;
    NSString *currentElementName;
    NSString *Cdata;
    NSMutableArray *rssArr;
}
@property(retain,nonatomic)   NSMutableString *currentText;
@property(retain,nonatomic)   NSMutableArray *rssArr;
-(BOOL)parser:(NSString*)string;
@end

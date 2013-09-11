//
//  NLMoreReviewsData.h
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-12.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLMoreReviewsData : NSObject<NSXMLParserDelegate>

{
    NSMutableArray *parserObjects;
    NSMutableDictionary *twitterDic;
    NSMutableString *currentText;
    NSString *currentElementName;
    NSString *Cdata;
    NSMutableArray *rssArr;
}
@property(retain,nonatomic) NSString *type_tag;
@property(retain,nonatomic)   NSMutableString *currentText;
@property(retain,nonatomic)   NSMutableArray *rssArr;
-(BOOL)parser:(NSString*)string;
@end

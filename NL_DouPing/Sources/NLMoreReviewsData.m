//
//  NLMoreReviewsData.m
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-12.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMoreReviewsData.h"
#import "NLRssInfo.h"
@implementation NLMoreReviewsData
@synthesize rssArr,currentText,type_tag;

- (void)dealloc
{
    [type_tag release];
    [currentText release];
    [rssArr release];
    [super dealloc];
}

-(BOOL)parser:(NSString*)string
{
    //系统自带的
    NSXMLParser *par = [[[NSXMLParser alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]]autorelease];
    [par setDelegate:self];//设置NSXMLParser对象的解析方法代理
    return [par parse];//调用代理解析NSXMLParser对象，看解析是否成功   }
    
}



#pragma mark xmlparser
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{    
    parserObjects = [[[NSMutableArray alloc]init] autorelease];
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
       
    self.currentText = [[NSMutableString alloc]init];
    [currentText release];
    if ([elementName isEqualToString:@"entry"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        twitterDic = newNode;
        [parserObjects addObject :newNode];
        [newNode release];
    }
    else if(twitterDic) {
//        
//        NSString * rellink = @"";
//        if (attributeDict.count >=2) {
//            
//            NSString *rel = [attributeDict objectForKey:@"rel"];
//            if ([rel isEqualToString:@"alternate"]) {
//                rellink = [attributeDict objectForKey:@"href"];
//                [twitterDic setObject:rellink forKey:@"link"];
//            }
//        }
        
        
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        
//        if (rellink.length>0) {
//            [twitterDic setObject :rellink forKey :elementName];
//            rellink = @"";
//        }else{
            [twitterDic setObject :string forKey :elementName];
//        }
        [string release ];
        currentElementName = elementName;
        

    }
    
    
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentText appendString:string];
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //   NSLog(@"%@",NSStringFromSelector(_cmd) );
    if ([elementName isEqualToString:@"entry"]) {
        twitterDic = nil;
    }else
        if ([elementName isEqualToString:currentElementName]) {
            
            if ([elementName isEqualToString:@"description"]
                ||[elementName isEqualToString:@"content:encoded"]) {
                [twitterDic setObject:Cdata forKey:currentElementName];
            }else {
                if (currentText.length>0) {
                    [twitterDic setObject:currentText forKey:currentElementName];

                }
            }
        }
    
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    self.rssArr = [NSMutableArray array];
    
    for (id o in parserObjects) {
        
        NSString *title = [o objectForKey:@"title"];
        NSString *reViewLink = [o objectForKey:@"id"];
        // NSRange range = [reViewLink rangeOfString:@"review"];
        NSArray *arr =  [reViewLink componentsSeparatedByString:@"/"];
        NSString *reviewId = [arr objectAtIndex:4];
        reviewId = [reviewId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *author = [ o objectForKey:@"name"];
        NSString *time = [o objectForKey:@"published"];
        NSString *summary = [o objectForKey:@"summary"];
        summary = [summary stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
        
        NSString *content_encoded = [o objectForKey:@"content:encoded"];
//        NSArray *arr2 =  [content_encoded componentsSeparatedByString:@"\""];
//        NSString *img = [arr2 objectAtIndex:1];
        
        NLRssInfo *info = [[[NLRssInfo alloc]init]autorelease];
        
        info.reViewId = reviewId;
        info.link = [NSString stringWithFormat:@"http://%@.douban.com/review/%@/",type_tag,reviewId];
        info.title = title;
        info.dc_creator = author;
        info.pubDate  = time;
        
        info.description = summary;
        [self.rssArr addObject:info];
    }
    
}
//获取cdata块数据
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    Cdata =[[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding] autorelease];
}

@end

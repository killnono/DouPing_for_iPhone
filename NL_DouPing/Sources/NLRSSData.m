//
//  NLRSSData.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-3.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLRSSData.h"

@implementation NLRSSData
@synthesize rssArr,currentText;

- (void)dealloc
{
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
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    parserObjects = [[[NSMutableArray alloc]init] autorelease];
   // twitterDic = [[NSMutableDictionary alloc]init];
//      currentText = [[NSString alloc ] init ];
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    self.currentText = [[NSMutableString alloc]init];
    [currentText release];
    if ([elementName isEqualToString:@"item"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        twitterDic = newNode;
        [parserObjects addObject :newNode];
        [newNode release];
    }
    else if(twitterDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        
        [twitterDic setObject :string forKey :elementName];
        [string release ];
        currentElementName = elementName;
    }

    
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
    [currentText appendString:string];
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//   NSLog(@"%@",NSStringFromSelector(_cmd) );
    if ([elementName isEqualToString:@"item"]) {
        twitterDic = nil;
    }else 
        if ([elementName isEqualToString:currentElementName]) {
        
            if ([elementName isEqualToString:@"description"]
                ||[elementName isEqualToString:@"content:encoded"]) {
                [twitterDic setObject:Cdata forKey:currentElementName];
            }else {
                [twitterDic setObject:currentText forKey:currentElementName];
            }
    }

}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
//    NSLog( @"%d %@" ,[ parserObjects count],[[ parserObjects objectAtIndex: 2 ] valueForKey: @"content:encoded" ]);
    
    self.rssArr = [NSMutableArray array];
    
    for (id o in parserObjects) {
        
        NSString *title = [o objectForKey:@"title"];
        NSString *reViewLink = [o objectForKey:@"link"];
       // NSRange range = [reViewLink rangeOfString:@"review"];
       NSArray *arr =  [reViewLink componentsSeparatedByString:@"/"];
        NSString *reviewId = [arr objectAtIndex:4];
        NSString *author = [ o objectForKey:@"dc:creator"];
        NSString *time = [o objectForKey:@"pubDate"];
        NSString *summary = [o objectForKey:@"description"];
        summary = [summary stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];

        NSString *content_encoded = [o objectForKey:@"content:encoded"];
        NSArray *arr2 =  [content_encoded componentsSeparatedByString:@"\""];
        NSString *img = [arr2 objectAtIndex:1];
        
        NLRssInfo *info = [[[NLRssInfo alloc]init]autorelease];
  

        info.link =[reViewLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        info.title = title;
        info.dc_creator = author;
        info.pubDate  = time;
        info.reViewId = reviewId;
        info.description = summary;
        info.img = img;
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

//
//  NLSearchObject.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLSearchObject.h"
#import "NLModelObject.h"
#import "JSON.h"
#import "NLBookInfo.h"
#import "NLMovieInfo.h"
#import "NLMusicInfo.h"
@implementation NLSearchObject
@synthesize arrInfo,totals,_tag;
- (void)dealloc
{
    [arrInfo release];
    [totals release];
    [_tag release];
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
    if (_tag == nil) {
        self._tag = @"book";
    }
   
    NSMutableArray *a = [[NSMutableArray alloc]init];
    self.arrInfo = a;
    [a release];
    NSMutableDictionary *dic = [jsonString JSONValue];  
    
    self.totals =[dic objectForKey:@"count"];
    

    NSMutableArray *entryArr ;
    
    if ([@"movie" isEqualToString: _tag]) {
        entryArr = [dic objectForKey:@"subjects"];
    }else{
    entryArr = [dic objectForKey:[NSString stringWithFormat:@"%@s",_tag]];//获取数组实体
    }
    if (entryArr && ![entryArr isEqual:[NSNull null]]) {
        
        
        if ([@"book" isEqualToString:_tag]) {
            
            
            for (id o in entryArr) {
                NLBookInfo *bi = [[[NLBookInfo alloc] init] autorelease];
                NSString *title = [o objectForKey:@"title"];
                
                NSString *url = [o objectForKey:@"url"];//
                
                NSString *imageURL = [o objectForKey:@"image"];
                
                NSArray *a = [o objectForKey:@"author"];
                NSMutableString *as = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;
                for (NSString *s in a) {
                    [as appendString:s];
                    [as appendString:@" "];
                }
                
                NSString *summary = [o objectForKey:@"summary"];
                
                bi.title = title;
                bi.url = url;
                bi.image = imageURL;
                bi.author = as;
                bi.summary = summary;
                [arrInfo addObject:bi];
            }
            
        } else if([@"music" isEqualToString:_tag]) {
            
            for (id o in entryArr) {
                NLMusicInfo *bi = [[[NLMusicInfo alloc] init] autorelease];
                NSString *title = [o objectForKey:@"title"];
                
                
                NSString *idURl = [o objectForKey:@"id"];//
                idURl = [NSString stringWithFormat:@"http://api.douban.com/v2/music/%@",idURl];
                
                NSString *imageURL = [o objectForKey:@"image"];
                
                NSArray *a = [o objectForKey:@"author"];
                NSMutableString *as = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;
                for (id s in a) {
                    [as appendString:[s objectForKey:@"name"]];
                    [as appendString:@"/"];
                }
                NSString *as1 = @"";
                if (as.length !=0) {
                    as1 = [as substringToIndex:([as length]-1)];
                    
                }

                
                
                NSArray *a1= [[o objectForKey:@"attrs"] objectForKey:@"pubdate"];
                NSMutableString *ps = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;
                if (a1.count > 0) {
                    for (NSString *s in a1) {
                        [ps appendString:s];
                        [ps appendString:@"/"];
                    }
                }
                
                NSArray *b= [[o objectForKey:@"attrs"] objectForKey:@"publisher"];
                
                if (b.count > 0) {
                    for (NSString *s in b) {
                        [ps appendString:s];
                        [ps appendString:@"/"];
                    }
                }
                NSString *cast1 = @"";
                if (ps.length !=0) {
                    cast1 = [ps substringToIndex:([ps length]-1)];
                    
                }
                
                bi.title = title;
                bi.url = idURl;
                bi.image = imageURL;
                bi.author = as1;
                bi.cast = cast1;
                [arrInfo addObject:bi];
            }
            
        }else if ([@"movie" isEqualToString:_tag]) {
            
            for (id o in entryArr) {
                NLMovieInfo *mi = [[[NLMovieInfo alloc] init] autorelease];
                
                NSString *title = [o objectForKey:@"title"];
                 NSString *a_title = [o objectForKey:@"original_title"];
                
                
                if ([self isDigitalOrAlpha:title]) {
                    title = a_title;
                }
                
                NSString *url = [o objectForKey:@"id"];//
                
                NSArray *arr1 = [url componentsSeparatedByString:@"/"];
                
                NSString *idURl = @"";
                if (arr1.count >0) {
                    idURl = [arr1 lastObject];
                }
                ///v2/movie/subject/1054395/reviews
                idURl = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/%@",idURl];
                
                NSString *imageURL = [[o objectForKey:@"images"] objectForKey:@"medium"];
                NSLog(@"图片地址：%@",imageURL);
                
                
                NSString *year = [o objectForKey:@"year"];
                
                NSString *average = [[o objectForKey:@"rating"] objectForKey:@"average"];
                NSMutableString *as = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;

                [as appendFormat:@"【%@】 \t  上映时间:%@   豆瓣平均评分:%@",a_title,year,average];
                
                
//            
//                NSArray *au= [o objectForKey:@"author"];
//                
//                NSMutableString *as = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;
//                
//                if (au.count >0) {
//                    for (id s in au) {
//                        [as appendString:[s objectForKey:@"name"]];
//                        [as appendString:@"/"];
//                    }
//                }
//               
//                 NSString *as1 = @"";
//                if (as.length !=0) {
//                    as1 = [as substringToIndex:([as length]-1)]; 
//
//                }
//                
//                
//                NSArray *a= [[o objectForKey:@"attrs"] objectForKey:@"pubdate"];
//                NSMutableString *ps = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;
//                
//                if (a.count > 0) {
//                    for (NSString *s in a) {
//                        [ps appendString:s];
//                        [ps appendString:@"/"];
//                    }
//                }
//                
//                
//                NSArray *b= [[o objectForKey:@"attrs"] objectForKey:@"cast"];
//                
//                if (b.count > 0) {
//                    for (NSString *s in b) {
//                        [ps appendString:s];
//                        [ps appendString:@"/"];
//                    }
//                }
//               NSString *cast1 = @"";
//                if (ps.length !=0) {
//                    cast1 = [ps substringToIndex:([ps length]-1)]; 
//
//                }

                mi.title = title;
                mi.cast = as;
                mi.image = imageURL;
//                mi.author = as1;
                [arrInfo addObject:mi];
                mi.url = idURl;
            }

            
        }
        
                   
//            
//            //关于内容
//            NSArray *attachmentsArr = [o objectForKey:@"attachments"];
//            
//            if ([attachmentsArr isEqual: [NSNull null]] || attachmentsArr.count < 1) {
//                continue;
//            }
//            NSDictionary *firstDic = [attachmentsArr objectAtIndex:0];
//            NSString *description = [firstDic objectForKey:@"description"];//描述
//            NSString *title = [firstDic objectForKey:@"title"];//标题
//            NSString *short_title = [o objectForKey:@"short_title"];//比如，写了新日记，推荐照片
//            
//            NLFriendsShuoInfo *info = [[[NLFriendsShuoInfo alloc] init]autorelease];
//            info.username = screen_name;
//            info.userImageLink = image;
//            info.text = text;
//            info.title = title;
//            info.content = description;
//            info.short_title = short_title;
//            
//            [arrInfo addObject:info];
            
    
        
        
    }
    
}

@end

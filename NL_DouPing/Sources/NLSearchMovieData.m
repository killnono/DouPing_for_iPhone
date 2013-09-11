//
//  NLSearchMovieData.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-6.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLSearchMovieData.h"
#import "JSON.h"
@implementation NLSearchMovieData
@synthesize cast,garde,title,author,summary,imageURl,pubTime,urlID;
- (void)dealloc
{
    [pubTime release];
    [cast release];
    [garde release];
    [author release];
    [summary release];
    [imageURl release];
    [urlID release];
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
       
    NSMutableDictionary *dic = [jsonString JSONValue];  
    
   
  id av = (NSString*)[[dic objectForKey:@"rating"] objectForKey:@"average"]; 
    if (![av isKindOfClass:[NSString class]]) {
        NSNumber *ns = [[NSNumber alloc] init];
        ns = av;
       
        self.garde = [NSString stringWithFormat:@"%.1f", [ns doubleValue]];
    }else {
        self.garde = av;
    }
    
    
    NSString *ti = [dic objectForKey:@"title"];
    NSString *a_title = [dic objectForKey:@"alt_title"];
    if ([self isDigitalOrAlpha:ti]) {
        ti = a_title;
    }
    self.title =ti;
      
    NSArray *au= [dic objectForKey:@"author"];
    NSMutableString *as = [[[NSMutableString alloc] initWithCapacity:0]autorelease];
    if (au.count >0) {
        for (id s in au) {
            [as appendString:[s objectForKey:@"name"]];
            [as appendString:@"/"];
        }
    }
    NSString *as1 = @"";
    if (as.length !=0) {
        as1 = [as substringToIndex:([as length]-1)]; 
    }
    
    self.author = as1;
    
    
    NSArray *a= [[dic objectForKey:@"attrs"] objectForKey:@"pubdate"];
    NSMutableString *ps = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;
    if (a.count > 0) {
        for (NSString *s in a) {
            [ps appendString:s];
            [ps appendString:@"/"];
        }
    }
    NSString *a2 = @"";
    if (ps.length !=0) {
        a2 = [ps substringToIndex:([ps length]-1)]; 
    }

    self.pubTime = a2;
    
    
    NSArray *b= [[dic objectForKey:@"attrs"] objectForKey:@"cast"];
    NSMutableString *cs = [[[NSMutableString alloc] initWithCapacity:0] autorelease];;

    if (b.count > 0) {
        for (NSString *s in b) {
            [cs appendString:s];
            [cs appendString:@"/"];
        }
    }
    NSString *cast1 = @"";
    if (cs.length !=0) {
        cast1 = [cs substringToIndex:([cs length]-1)]; 
        
    }

    self.cast = cast1;
    self.summary = [dic objectForKey:@"summary"];
    
    self.imageURl = [dic objectForKey:@"image"];
    
    NSString *http = [dic objectForKey:@"mobile_link"];
    NSArray *arrid = [http componentsSeparatedByString:@"/"];
    if (arrid.count>=7) {
        self.urlID = [arrid objectAtIndex:5];
    }
}

@end

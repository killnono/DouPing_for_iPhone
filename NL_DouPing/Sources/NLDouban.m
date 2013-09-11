//
//  NLDouban.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLDouban.h"
#import "ASIHTTPRequest.h"
#import "NLMiniBlogData.h"
#import "NLModelObject.h"
#import "ASIFormDataRequest.h"
#import "NLDouBanConfiguration.h"
#import "NLAppDelegate.h"
#import "NLFriendsShareData.h"
@implementation NLDouban
@synthesize _delegate;

- (id)init
{
    if (self == [super init]) {
        
    }
    
    return self;
}
- (void)MiniBlog:(NLMiniBlogData *)data delegate:(NSObject<NLDoubanRequestDelegate> *)delegate
{
    self._delegate = delegate;
    NSString *userid = data.userId;
    NSString *urlString = [NSString stringWithFormat:@"http://api.douban.com/people/%@/miniblog?alt=json",userid];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)RssReviewWithTag:(NSString*)RssTag delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = [NSString stringWithFormat:@"http://www.douban.com/feed/review/%@",RssTag];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];

}

-(void)RssReviewWithObjectID:(NSString *)objectID withTag:(NSString*)tag delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
 
    NSString *urlString;
    if ([tag isEqualToString:@"movie"]) {
      urlString  = [NSString stringWithFormat:@"https://api.douban.com/v2/movie/subject/%@/comments?start=0&count=20",objectID];
    }else{
       urlString = [NSString stringWithFormat:@"http://api.douban.com/%@/subject/%@/reviews?start-index=1&max-results=20",tag,objectID];
    }
    
//      urlString = [NSString stringWithFormat:@"http://api.douban.com/%@/subject/%@/reviews?start-index=1&max-results=20",tag,objectID];
    
    self._delegate = delegate;
   
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    
    if ([tag isEqualToString:@"movie"]){
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];
    }
    request.delegate = self;
    [request startAsynchronous];
}

-(void)getAuthorizationMiniBlogWithData: (NLFriendsShuoShuoData*)data  delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = @"https://api.douban.com/shuo/statuses/user_timeline/3639987";
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];
    request.delegate = self;
    [request startAsynchronous];
}

//获取授权用户关注的广播
-(void)getAuthorizationmFriendsMiniBlogWithData: (NLFriendsShuoShuoData*)data  delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{//@"http://api.douban.com/people/nonoforever/miniblog/contacts";
    self._delegate = delegate;
    NSString *urlString = @"https://api.douban.com/shuo/statuses/home_timeline";
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)AuthorizationWithUser:(id)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    NSString *name = @"316946356@qq.com";
    NSString *ps = @"1314520ck";

    NSString *urlString = [NSString stringWithFormat:@"https://api.douban.com/auth2/token?client_id=0993242d124692cb1cb96c8736d3b861&client_secret=b996445a44408900&redirect_uri=http://www.douban.com&grant_type=password&username=%@&password=%@",name,ps];
  //  urlString = @"https://api.douban.com/people/@me";
//    ASIFormDataRequest *formDataRequest = [ASIFormDataRequest requestWithURL:nil]; 
//    urlString = [formDataRequest encodeURL:urlString];
    
    
//   urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  //  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
//    [dic setObject:@"Bearer 7a497254e1d681616edc56fea5838423" forKey:@"Authorization"];
//    [request setRequestHeaders:dic];
    [request setRequestMethod:@"POST"];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)ReViewDetailById:(NSString*)reviewId delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = [NSString stringWithFormat:@"http://api.douban.com/review/%@",reviewId];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];

    request.delegate = self;
    [request startAsynchronous];
}

-(void)Access_token:(NSString*)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/token"];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:client_id forKey:@"client_id"];
    [request setPostValue:client_secret forKey:@"client_secret"];
    [request setPostValue:redirect_url forKey:@"redirect_uri"];
    [request setPostValue:@"authorization_code" forKey:@"grant_type"];
    [request setPostValue:data forKey:@"code"];

    request.delegate = self;
    [request startAsynchronous];
}

-(void)SingleShuoshuo:(NSString*)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    NSString *urlString = [NSString stringWithFormat:@"https://api.douban.com/shuo/statuses/%@",data];
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];

    request.delegate = self;
    [request startAsynchronous];
}

-(void)getBookMovieMusicFromFriendsWithData:(NLFriendsShareData*)data delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/shuo/v2/statuses/home_timeline?start=%@&count=%@&category=culture",@"0",@"200"];
    
    
//    NSString *urlStr = @"https://api.douban.com/shuo/v2/statuses/home_timeline";
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;

    NSLog(@"token:%@",token);

    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];

    request.delegate = self;
    [request startAsynchronous];
    
}


-(void)searchObjectWithTag:(NSString*)tag key:(NSString*)key delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
  NSString *enContent = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *urlStr = [NSString stringWithFormat:@"https://api.douban.com/v2/%@/search?q=%@",tag,enContent];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
    [request setRequestHeaders:dic];

    request.delegate = self;
    [request startAsynchronous];
    
}

-(void)searchMovieInfotWithAPI:(NSString*)apiURl delegate:(NSObject <NLDoubanRequestDelegate>*)delegate
{
    self._delegate = delegate;
    
    NSURL *url = [NSURL URLWithString:apiURl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1]; 
    NLAppDelegate *de =  (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *token = de.token;
    NSString *value = [NSString stringWithFormat:@"Bearer %@",token];
    [dic setObject:value forKey:@"Authorization"];
//    [request setRequestHeaders:dic];

    request.delegate = self;
    [request startAsynchronous];

}

#pragma mark- request delegate Methods
- (void)requestFinished:(ASIHTTPRequest *)request
{
    int code = [request responseStatusCode];
    NSData *responseData = [request responseData];
    NSString *respString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"服务端返回内容%@",respString);
    [_delegate handleReponse:respString ResponseStatusCode:code];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    int code = [request responseStatusCode];
    NSData *responseData = [request responseData];
    NSString *respString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"服务端返回内容%@",respString);
    [_delegate handleReponse:@"网络错误" ResponseStatusCode:code];

}

@end

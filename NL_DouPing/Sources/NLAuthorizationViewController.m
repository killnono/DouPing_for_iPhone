//
//  NLAuthorizationViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLAuthorizationViewController.h"
#import "JSON.h"
//#import "DefineHeader.h"
@interface NLAuthorizationViewController ()
{
    MBProgressHUD *HUD;
    NSString *urlpath;
}
@property(retain,nonatomic)NLDouban *douban;
@property(retain,nonatomic)UIActivityIndicatorView *activityView;

@end

@implementation NLAuthorizationViewController
//自定义的重定向url
NSString *_redirect = @"http://www.nono_lilith.com";
NSString *_api_key = @"0bd73c44ae7f55d72385b4ce0b7e0185";
NSString *_douban_register =  @"http://www.douban.com/accounts/register";
NSString *_resure_url =  @"http://www.nono_lilith.com/?error=access_denied";

@synthesize activityView,douban;
- (void)dealloc
{
    [activityView release];
    [douban release];
    [super dealloc];
}

-(void)isNet
{
    if (![NLAppDelegate shareAPPDelegate].isAvailableNet) {
        UIAlertView * a = [[ UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
        [a release];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading_bg.png"]];
    self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame =CGRectMake(260, 0, 40, 40);
   
    [self.navigationController.navigationBar addSubview:activityView];
    
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?(416+88):416)];
    webView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading_bg.png"]];
    [self.view addSubview:webView];
    webView.scalesPageToFit=YES;
    [webView release];
    
    [activityView release];
    urlpath = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code&display=popup",_api_key,_redirect];
    NSURL *url=[NSURL URLWithString:urlpath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    [webView loadRequest:request];
    
	// Do any additional setup after loading the view.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self back];
}
-(void)fetchToken:(NSString*)code
{
    self.douban = [[NLDouban alloc]init];
    [douban release];
    [douban Access_token:code delegate:self];
}

#pragma mark UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [self isNet];
    BOOL b = YES;
    
    NSString *targetUrl = request.URL.absoluteString;
    NSLog(@"%@",targetUrl);
    if ([_douban_register isEqualToString:targetUrl]) {//注册，直接跳转浏览器
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_douban_register]];
        b = NO;
    }else if ([targetUrl isEqualToString:_resure_url]) {//拒绝授权
        b = NO;
        HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
            [HUD setMode:MBProgressHUDModeText];
        [self.view.window addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"拒绝授权";
        [HUD show:YES];
        [HUD hide:YES afterDelay:3];
    }
    
    
    //#access_token
    NSRange range = [targetUrl rangeOfString:@"http://www.nono_lilith.com/?code="];
    if (range.length > 0) {//点击了授权，并且成功了
        NSString *tokenMore = [targetUrl substringFromIndex:range.location+range.length];
        NSString *token = [[tokenMore componentsSeparatedByString:@"&"] objectAtIndex:0];
        NSLog(@"获取的token = %@",token);
        
        [self fetchToken:token];

        b = NO;
    }
        
    
    return b;
}

-(void)sleepTask
{
    sleep(3);
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
    [self back];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
        [activityView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityView stopAnimating];
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"执行了viewDidDisappear");
    if (activityView.isAnimating) {
        [activityView stopAnimating];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"执行了viewWillDisappear");

    if (activityView.isAnimating) {
        [activityView stopAnimating];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    if (activityView.isAnimating) {
        [activityView stopAnimating];
    }
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark delagate methods
-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
//    [HUD hide:YES afterDelay:0.5];
    if (code == 200) {
      
       NSDictionary *dic = [response JSONValue];
        NSString *token = [dic objectForKey:@"access_token"];
        
        _delegate = (NLAppDelegate*)[[UIApplication sharedApplication] delegate];
        _delegate.isLogin = YES;
        _delegate.token = token;
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
        [HUD setMode:MBProgressHUDModeText];
        [self.view.window addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"授权成功";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
       
    }
}



@end

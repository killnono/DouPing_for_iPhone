//
//  NLReviewDetailViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLReviewDetailViewController.h"
#import "NLAppDelegate.h"
#import "GADBannerView.h"
@interface NLReviewDetailViewController ()

@property(retain,nonatomic)UIActivityIndicatorView *activityView;
@property(retain,nonatomic)UIBarButtonItem *refreshBtn;
@property(retain,nonatomic)UIToolbar *toolbar;

@end

@implementation NLReviewDetailViewController
@synthesize reviewId,douban,webView,activityView,refreshBtn,toolbar;
- (void)dealloc
{
    [reviewId release];
    [douban release];
    [webView release];
    [activityView release];
    [refreshBtn release];
    [toolbar release];
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

-(void) fetchNet
{
    
    [douban ReViewDetailById:reviewId delegate:nil];
    
}

- (void)initData
{
    self.douban = [[NLDouban alloc]init];
    [douban release];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (activityView.isAnimating) {
        [activityView stopAnimating];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.title = @"评论详情";
   
 
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?(416-44+88):(416-44))];
    [self.view addSubview:webView];
    webView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    webView.scalesPageToFit=YES;
    [webView release];
    
    NSString *urlpath = [NSString stringWithString:reviewId];
    NSURL *url=[NSURL URLWithString:urlpath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
    
    
    //工具栏
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,iPhone5?(416+88):416, 320, 44)];
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:toolbar];
    [toolbar release];
    
    UIBarButtonItem *front = [[UIBarButtonItem alloc] initWithTitle:@"上一页" style:UIBarButtonItemStyleBordered target:self action:@selector(front)];
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *fixspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixspace.width = 20;
    
    
    //刷新标签
   self.refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    NSArray *arr = [NSArray arrayWithObjects:front,next,space,refreshBtn,fixspace,nil];
    
    [toolbar setItems:arr];
    
    [front release];
    [space release];
    [next release];
    [refreshBtn release];
    [fixspace release];
    //loading指示器
    self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame =CGRectMake(260, 0, 40, 40);
    [self.navigationController.navigationBar addSubview:activityView];
    
    [activityView release];
    [self addAdmob];
    
    
   // toolbar 
	// Do any additional setup after loading the view.
}



//添加广告
-(void) addAdmob{
    // Create a view of the standard size at the bottom of the screen.
    GADBannerView *bannerView_ = [[GADBannerView alloc]
                                  initWithFrame:CGRectMake(0.0,
                                                           (iPhone5?568-44:480-44) -20,
                                                           GAD_SIZE_320x50.width,
                                                           GAD_SIZE_320x50.height)];//设置位置
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = ADBMOB_ID;//调用你的id
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    bannerView_.delegate = self;
    [self.view addSubview:bannerView_];//添加bannerview到你的试图
    
    // Initiate a generic request to load it with an ad.
    GADRequest * request = [GADRequest request];
    //        request.testing = YES;
    [bannerView_ loadRequest:request];
    [bannerView_ release];
}


#pragma mark - admob delegate
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    CGRect tmpFrame = view.frame;
    if (tmpFrame.origin.y >= (iPhone5?568-44:480-44) -20) {
        tmpFrame.origin.y = tmpFrame.origin.y-50;
        view.frame = tmpFrame;
        
        
        tmpFrame = toolbar.frame;
        tmpFrame.origin.y = tmpFrame.origin.y -50;
        toolbar.frame =tmpFrame;
        
        tmpFrame = webView.frame;
        tmpFrame.size.height = tmpFrame.size.height -50;
        webView.frame =tmpFrame;
        
      
        
    }
    
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refresh
{
    [webView reload];
}
//前一页
-(void)front
{
    if (webView.canGoBack) {
        [webView goBack];
    }
    
}

//后一页
-(void)next
{
    if (webView.canGoForward) {
        [webView goForward];
    }
}


#pragma mark UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self isNet];
    return YES;

}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    refreshBtn
  [activityView startAnimating];   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    NSString *url =  webView.request.URL.absoluteString;
    
     [activityView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityView stopAnimating];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

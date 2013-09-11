//
//  NLReviewViewController.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-2.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLReviewViewController.h"
#import "TBXML.h"
#import "NLRssInfo.h"
#import "NLRSSData.h"
#import "NLReviewCell.h"
#import "UIImageView+NLDispatchLoadImage.h"
#import "NLReviewDetailViewController.h"
#import "GADBannerView.h"
@interface NLReviewViewController ()
@end

@implementation NLReviewViewController
@synthesize dataArr,douban;
- (void)dealloc
{
    [dataArr release];
    [douban release];
    [super dealloc];
}
-(void) fetchNet
{
  
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"数据加载中...";
	HUD.delegate = self;
    [HUD show:YES];
    [douban RssReviewWithTag:currentTAG delegate:self];
}

- (void)initData
{
    currentTAG = @"latest";
    intTag = 0;
    self.dataArr = [NSMutableArray array];
    self.douban = [[NLDouban alloc]init];
    [douban release];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (dataArr.count == 0) {
        [self fetchNet];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.title = @"评论TOP20";
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 10)];
    [overlayView setBackgroundColor:[UIColor colorWithRed:108/255.0f green:108.0/255.0f blue:108.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar addSubview:overlayView]; // navBar is your UINavigationBar instance
    [overlayView release];
    
    SlidingTabsControl* tabs = [[SlidingTabsControl alloc] initWithTabCount:4 delegate:self];
    [tabs selectedIndex:1];
    [self.view addSubview:tabs];
    
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320,iPhone5?(376+88):376)];
    tv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tv.tag = 100;
    tv.dataSource = self;
    tv.delegate = self;
    tabV = tv;
    [self.view addSubview:tabV];
    
    [self addAdmob];
    
    
    
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
        
        tmpFrame = tabV.frame;
        tmpFrame.size.height = tmpFrame.size.height -50;
        tabV.frame =tmpFrame;
        
    }
    
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - slid
- (UILabel*) labelFor:(SlidingTabsControl*)slidingTabsControl atIndex:(NSUInteger)tabIndex
{
    UILabel* label = [[[UILabel alloc] init] autorelease];
    switch (tabIndex) {
        case 0:
            label.text = [NSString stringWithFormat:@"最新评论"];
            break;
            
        case 1:
            label.text = [NSString stringWithFormat:@"最新书评"];
            break;
        case 2:
            label.text = [NSString stringWithFormat:@"最新影评"];
            break;
            
        case 3:
            label.text = [NSString stringWithFormat:@"最新乐评"];
            break;
    }
    
    return label;
    
}
- (void) touchUpInsideTabIndex:(NSUInteger)tabIndex
{
    if (intTag ==tabIndex)
        return;
    [self.dataArr removeAllObjects];
    [tabV reloadData];
    intTag = tabIndex;
    
    switch (tabIndex) {
        case 0:
            currentTAG = @"latest";
            break;
            
        case 1:
            currentTAG = @"book";
            break;
        case 2:
            
            currentTAG = @"movie";
            break;
        case 3:
            
            currentTAG = @"music";
            break;
    }
    
    [self fetchNet ];
}
- (void) touchDownAtTabIndex:(NSUInteger)tabIndex
{
    
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *identifier = @"reCell";
    
    NLReviewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NLReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NLRssInfo *info = [self.dataArr objectAtIndex:indexPath.row];
    
  
    [cell restAllView];
    cell.title.text= info.title;
    cell.who.text = info.dc_creator;
    cell.content.text = info.description;
    cell.Time.text  = info.pubDate;
    NSString *imgrsc = info.img;
    [cell.imageV setImageFromUrl:imgrsc];
    
    return cell;
}

#pragma mark - UITableViewDalegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NLRssInfo *info = [self.dataArr objectAtIndex:indexPath.row];
    
    NLReviewDetailViewController *vc = [[NLReviewDetailViewController alloc] init];
    vc.reviewId = info.link;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:vc animated:YES];
    
    [vc release];
}

-(void)showToastWithMessage:(NSString*)mes
{
   HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    HUD.labelText = mes;
        
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
}

#pragma mark delagate methods
-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
    [HUD hide:YES afterDelay:0.2];
    if (code == 200) {
        NLRSSData *data = [[NLRSSData alloc]init];
        BOOL b = [data parser:response];
        if (b) {
            self.dataArr =  data.rssArr;
        }
        [data release];
        [tabV reloadData];
    }else {
        [self showToastWithMessage:@"请求失败"];
    }
}

////递归子方法
//- (void)recurrence:(TBXMLElement *)element {
//    
//    NSString *eleName = [TBXML elementName:element]; 
//    NSString *eleText = [TBXML textForElement:element];
//    if ([eleName isEqualToString:@"item"]) {
//        self recurrence:element
//    }
//    
//    
//    
//    
//    do {
//        
//        NSString *eleName = [TBXML elementName:element]; 
//        NSString *eleText = [TBXML textForElement:element]; 
//        
//        //递归处理子树
//        if (element->firstChild) {
//            NSLog(@"<%@>:",eleName);// Display the name of the element
//            
//            [self recurrence:element->firstChild];
//        }else {
//            NSLog(@"<%@>:%@",eleName,eleText);// Display the name of the element
//            
//            TBXMLElement *parent = element->parentElement;
//            if ([[TBXML elementName:parent] isEqualToString:@"item"]) {
//                NLRssInfo *info = [[[NLRssInfo alloc]init] autorelease];
//                
//                if ([eleName isEqualToString:@"title"]) {
//                    info.title = eleText; 
//                }
//                
//                
//                [dataArr addObject:info];
//            }
//            
//        }
//        
//        
//        //迭代处理兄弟树
//    } while ((element = element->nextSibling));
//}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
     HUD = nil;
}
@end

//
//  NLMyHomeViewController.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-30.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMyHomeViewController.h"
#import "SlidingTabsControl.h"
#import "NLUserInfoView.h"
#import "NLDouban.h"
#import "NLMiniBlogData.h"
#import "NLMiniBlogInfo.h"
#import "NLMiniBlogCell.h"
#import "NLCommonHelper.h"
#import "NLFriendsShuoInfo.h"
#import "NLFriendsShuoShuoData.h"
#import "UIImageView+NLDispatchLoadImage.h"
#import "NLShuoshuoDetailViewController.h"
#import "NLFriendsShareData.h"
#import "NLFriendShareInfo.h"
#import "NLSearchViewController.h"
#import "MBProgressHUD.h"
#import "NLAppDelegate.h"
#define SIZE @"10"

@interface NLMyHomeViewController ()
{
    int start;
    MBProgressHUD *HUD;

    
}
@property(retain,nonatomic)NLFriendsShareData *data;
@property(retain,nonatomic)NLDouban *douban;
@end

@implementation NLMyHomeViewController
@synthesize contentView,tabV,data,miniArr,douban,refresView,Tabcell;

- (void)dealloc
{
    [contentView release];
    [Tabcell release];
    [tabV release];
    [data release];
    [douban release];
    [refresView release];
    [miniArr release];
    [super dealloc];
}

- (void)fetchFriendsMiniBlog
{
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view.window];
        [self.navigationController.view.window addSubview:HUD];
        HUD.labelText = @"数据加载中...";
        HUD.delegate = self;
        [HUD show:YES];
           
        self.douban = [[NLDouban alloc]init];
        [douban release];
        
        self.data = [[NLFriendsShareData alloc] init];
        [data release];
        data.count = SIZE;
        data.start = [NSString stringWithFormat:@"%d",start];
        [douban getBookMovieMusicFromFriendsWithData:data delegate:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initdata
{
    
    self.miniArr = [[NSMutableArray alloc] initWithCapacity:0];
    [miniArr release];
    start = 0;
  
}

- (void)initMyView
{
   
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?416+88:416)];
    tv.tag = 100;
    tv.dataSource = self;
    tv.delegate = self;
     self.tabV = tv;
    [tv setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [self.view addSubview:tabV];
    [tv release];
    
    EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tv.bounds.size.height, self.view.frame.size.width, tv.bounds.size.height)];
    view.delegate = self;
    [tv addSubview:view];
    self.refresView = view;
    [view release];
    
}
- (void)viewDidLoad
{  [super viewDidLoad];
    self.title = @"友邻怎么说";
   
    [self initdata];
    [self initMyView];
    
    [self fetchFriendsMiniBlog];
    
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger i = miniArr.count;
    
    return ((start <= 0) || (start>=i))? start:start+1;
}


-(void)showMore
{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view.window];
    [self.navigationController.view.window addSubview:HUD];
    HUD.labelText = @"加载更多...";
    HUD.delegate = self;
    [HUD show:YES];
    
    start = start+10>miniArr.count?miniArr.count:start+10;
//    - (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
    [tabV reloadData];
    
    [HUD hide:YES afterDelay:1.5];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *identifier = @"nono";
    static NSString *identifier_more = @"more";
    UITableViewCell *cell  ;
    if (indexPath.row == start) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_more];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_more] autorelease];
                   
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter ;
        cell.textLabel.text = @"更多";
        return cell;
    } 
    
   cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        //从nib文件中加载一个
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchObjectCell" owner:self options:nil];
        
        if([nib count] > 0){
            cell = self.Tabcell;
        }else{
            NSLog(@"加载 nib文件失败");
        }
    }
    
    NLFriendShareInfo *info = [self.miniArr objectAtIndex:indexPath.row];
    NSUInteger i_image = 10;
    NSUInteger i_name = 11;
    NSUInteger i_whichdone = 12;
    NSUInteger i_metatile = 13;
    NSUInteger i_metades =14;
    NSUInteger i_suosuo = 15;
    
    UIImageView *iv =  (UIImageView*)[cell viewWithTag:i_image];
    UILabel *nl = (UILabel*)[cell viewWithTag:i_name];
    UILabel *wl = (UILabel*)[cell viewWithTag:i_whichdone];
    UILabel *ml = (UILabel*)[cell viewWithTag:i_metatile];
    UILabel *dl = (UILabel*)[cell viewWithTag:i_metades];
    
    nl.text = nil;
    iv.image = [UIImage imageNamed:@"loading80*120.png"];
    wl.text = nil;
    ml.text = nil;
    dl.text = nil;
    
    nl.text = info.userName;
    [iv setImageFromUrl:info.uerImage];
    wl.text = info.title;
    ml.text = info.metaTitle;
    dl.text = info.metaDes;
    
    UILabel *suosuoBtn =  (UILabel*)[cell viewWithTag:i_suosuo];
    if ([info.type isEqualToString:@""]) {
        suosuoBtn.hidden = YES;
    }else {
        suosuoBtn.hidden = NO;
      
    }
    return cell;
}

#pragma mark - UITableViewDalegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == start?40:160;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == start) {
        [self showMore];
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NLFriendShareInfo *info = [self.miniArr objectAtIndex:indexPath.row];
    
    if ([info.type isEqualToString:@""])
        return;
    NLSearchViewController *vc = [[NLSearchViewController alloc]init ];
    vc._info = info;
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
   
    if (![NLAppDelegate shareAPPDelegate].isAvailableNet) {
        
        UIAlertView * a = [[ UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
        [a release];
    }
    
    [HUD hide:YES afterDelay:0.1];
    if (code == 200) {
        [self.data jsonString2Bean:response];    
       
        if (data.arrInfo.count == 0) {
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有相关广播记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [a show];
            [a release];
        }else{
        if (isLoading == YES)
              [miniArr removeAllObjects];
        
        [miniArr addObjectsFromArray:data.arrInfo];
        start = 10;
        [tabV reloadData];
        }
    }else{
        if (isLoading) {
            start = 10;
        }
        [self showToastWithMessage:@"请求失败"];
    }
    
    if (isLoading == YES) {
        isLoading = NO;
        [refresView egoRefreshScrollViewDataSourceDidFinishedLoading:tabV];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)doneLoadingTableViewData
{
    isLoading=NO;
    [refresView egoRefreshScrollViewDataSourceDidFinishedLoading:tabV];
}

#pragma mark - EGO deleagteMethods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{//实现触发刷新操作

        start = 0;
        isLoading = YES;
        [self fetchFriendsMiniBlog];
  
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{//返回loading状态
    return isLoading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{//返回刷新时间
    return [NSDate date];
    
}



#pragma mark - scrollView delegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView          //scrollview拖动时 调用ego。。。。view中的方法
{
    [refresView  egoRefreshScrollViewDidScroll:scrollView];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate   //结束拖动的时候 调用ego。。。view中的方法
{
    [refresView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
	[HUD release];
     HUD = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
@end


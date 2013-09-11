//
//  NLMoreReviewViewController.m
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-12.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMoreReviewViewController.h"
#import "NLMoreReviewsData.h"
#import "NLReviewCell.h"
#import "NLRssInfo.h"
#import "NLReviewDetailViewController.h"
@interface NLMoreReviewViewController ()

@property(retain,nonatomic)NLMoreReviewsData *data;
@end

@implementation NLMoreReviewViewController
@synthesize dataArr,douban,image,objectID,tag,data;
- (void)dealloc
{
    [tag release];
    [image release];
    [objectID release];
    [dataArr release];
    [douban release];
    [data release];
    [super dealloc];
}

-(void)fetchNet
{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"数据加载中...";
    [HUD show:YES];
    data.type_tag = tag;
    
    [douban RssReviewWithObjectID:self.objectID withTag: tag delegate:self];
}

- (void)initData
{

    self.dataArr = [NSMutableArray array];
    self.douban = [[NLDouban alloc]init];
     self.data = [[NLMoreReviewsData alloc]init];
    [data release];
    [douban release];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (dataArr.count == 0) 
    [self fetchNet];
    
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
    [self initData];
    self.title = @"热门评论";
    
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,iPhone5?(416+88):416)];
    tv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tv.tag = 100;
    tv.dataSource = self;
    tv.delegate = self;
    tabV = tv;
    [self.view addSubview:tabV];
    
	// Do any additional setup after loading the view.
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
    
    cell.title.text = nil;
    cell.who.text = nil;
    cell.content.text = nil;
    cell.Time.text = nil;
    cell.imageV.image = nil;
    
    cell.title.text= info.title;
    cell.who.text = info.dc_creator;
    cell.content.text = info.description;
    cell.Time.text  = info.pubDate;
    [cell.imageV setImage:self.image];
    
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

-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
    [HUD hide:YES afterDelay:0.5];
    if (code == 200) {
     
        BOOL b = [data parser:response];
        if (b) {
            self.dataArr =  data.rssArr;
        }
        if (data.rssArr.count == 0 ) {
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有相关记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [a show];
            [a release];
        }else [tabV reloadData];

    }else {
        [self showToastWithMessage:@"请求失败"];
    }

}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
    HUD = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  NLSearchViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLSearchViewController.h"
#import "NLSearchObject.h"
#import "NLModelObject.h"
#import "NLSearchObjectCellCell.h"
#import "NLBookInfo.h"
#import "NLMovieInfo.h"
#import "UIImageView+NLDispatchLoadImage.h"
#import "NLSearchObjectDetailViewController.h"
#import "MBProgressHUD.h"
#import "NLMusicInfo.h"
#import "NLAppDelegate.h"
@interface NLSearchViewController ()
{
    NSString *_tag;
    
}
@property(retain,nonatomic)MBProgressHUD *HUD;
@property(retain,nonatomic) NSMutableArray *arr;
@property(retain,nonatomic)NLDouban *db;
@property(retain,nonatomic)NLSearchObject *so;
@end

@implementation NLSearchViewController
@synthesize tav,HUD;

@synthesize seg;
@synthesize sb,db,so,arr,_info;

-(void)fetchObject:(NSString*)key
{
    
    if (![NLAppDelegate shareAPPDelegate].isAvailableNet) {
        UIAlertView * a = [[ UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
        [a release];
    }else{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"数据加载中...";
	HUD.delegate = self;
    [HUD show:YES];
    self.db = [[NLDouban alloc]init];
    [db release];
    
    self.so = [[NLSearchObject alloc] init];
    [so release];
    so._tag = _tag;
    [db searchObjectWithTag:_tag key:key delegate:self];
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

-(NSInteger)type2Index:(NSString*)type
{
    NSInteger i = 0;
    if ([type isEqualToString:@"book"]) {
        i = 0;
    }else if ([type isEqualToString:@"movie"]) {
        i = 1;
    }else if ([type isEqualToString:@"music"]) {
        i = 2;
    }
return i;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arr = [NSMutableArray array];
     self.title = @"书影音搜索";
    if (_info) {
        _tag = _info.type;
        seg.selectedSegmentIndex = [self type2Index:_info.type];
        
        NSArray *titleArr = [_info.metaTitle componentsSeparatedByString:@" "];
        if (titleArr.count > 0) {
            _info.metaTitle = [titleArr objectAtIndex:0];
        }
        sb.text = _info.metaTitle;
        [self fetchObject:_info.metaTitle];
    }else {
       _tag = @"book"; 
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSeg:nil];
    [self setSb:nil];
    [self setDb:nil];
    [self setSo:nil];
    [self setTav:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [seg release];
    [sb release];
    [db release];
    [so release];
    [arr release];
    [tav release];
    [HUD release];
    [_info release];
    [super dealloc];
}


- (IBAction)segChange:(id)sender {
    UISegmentedControl *sg = (UISegmentedControl*)sender;
    switch (sg.selectedSegmentIndex) {
        case 0:
            _tag = @"book";
            break;
            
        case 1:
            _tag = @"movie";
            break;
            
        case 2:
            _tag = @"music";
            break;
            
    }
    [arr removeAllObjects];
    [tav reloadData ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"nono";
    
    NLSearchObjectCellCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];  
    if (cell == nil) {  
        cell = [[NLSearchObjectCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident]; 
        
    }
    
    [cell restAllView];
    
    if ([@"book" isEqualToString:_tag]) {
        NLBookInfo *bs = [arr objectAtIndex:indexPath.row];
        cell.title.text = bs.title;
        cell.content.text = bs.summary;
        cell.who.text =[NSString stringWithFormat:@"作者:%@", bs.author];
        [cell.imageV setImageFromUrl:bs.image];
    }else if ([@"movie" isEqualToString:_tag]) {
        NLMovieInfo *ms = [arr objectAtIndex:indexPath.row];
        cell.title.text = ms.title;
        
        
        cell.content.text = ms.cast;
//        cell.who.text = [NSString stringWithFormat:@"导演:%@", ms.author];
        [cell.imageV setImageFromUrl:ms.image];
    }else if ([@"music" isEqualToString:_tag]) {
        NLMusicInfo *ms = [arr objectAtIndex:indexPath.row];
        cell.title.text = ms.title;
        cell.content.text = ms.cast;
        cell.who.text = [NSString stringWithFormat:@"演唱:%@", ms.author];
        [cell.imageV setImageFromUrl:ms.image];
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        NLMovieInfo *info = [arr objectAtIndex:indexPath.row];
        NLSearchObjectDetailViewController *vc = [[NLSearchObjectDetailViewController alloc] init];
        vc.urlID = info.url;
        vc.tag = _tag;
        [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)showToastWithMessage:(NSString*)mes
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    HUD.labelText = mes;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
}
#pragma mark Douban delegate methods
-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
    
    [HUD hide:YES afterDelay:0.2];
    if (code == 200) {
        [self.so jsonString2Bean:response];
        self.arr = so.arrInfo;
        if (so.arrInfo.count == 0 ) {
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有相关记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [a show];
            [a release];
        }else [tav reloadData];
    }else {
        [self showToastWithMessage:@"请求失败"];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
	[HUD release];
     HUD = nil;
}
#pragma mark -
#pragma mark sb delegate methods
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    searchBar.showsCancelButton = NO;

    [self fetchObject:sb.text];
    
}
// called when keyboard search button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
}
// called when bookmark button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.view endEditing:YES];
    searchBar.text = nil;
    searchBar.showsCancelButton = NO;
}
// called when cancel button pressed
@end

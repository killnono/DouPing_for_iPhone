//
//  NLAboutViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-14.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLAboutViewController.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
@interface NLAboutViewController ()
{
    NSMutableArray *dataArr;
    NSMutableArray *dataArr2;
    MBProgressHUD *HUD;

}

@property(retain,nonatomic)NSMutableArray *dataArr;
@property(retain,nonatomic)NSMutableArray *dataArr2;


//@property(retain,nonatomic)
@end

@implementation NLAboutViewController
@synthesize _tabV,dataArr,dataArr2;

- (void)dealloc
{
    [_tabV release];
    [dataArr2 release];
    [dataArr release];
    [super dealloc];
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
    self.title = @"关于";
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    //    [dataArr addObject:@"版本更新"];
    [dataArr addObject:@"关于应用"];
    [dataArr addObject:@"检查更新"];
    [dataArr addObject:@"去AppStore评分"];
    
    
    self.dataArr2 = [NSMutableArray arrayWithCapacity:0];
    [dataArr2 addObject:@"关于我"];
    [dataArr2 addObject:@"反馈"];
    
    self._tabV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tabV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    [self.view addSubview:_tabV];
    [_tabV release];
    
	// Do any additional setup after loading the view.
}


-(void)checkVersion
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"正在检查版本";
    HUD.delegate = self;
    [HUD show:YES];
    NSString *version = @"";
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=578878323"];
    ASIFormDataRequest *versionRequest = [ASIFormDataRequest requestWithURL:url];
    [versionRequest setRequestMethod:@"GET"];
    [versionRequest setDelegate:self];
    [versionRequest setTimeOutSeconds:150];
    [versionRequest addRequestHeader:@"Content-Type" value:@"application/json"];
    [versionRequest startSynchronous];
    
    //Response string of our REST call
    NSString* jsonResponseString = [versionRequest responseString];
    NSDictionary *loginAuthenticationResponse = [jsonResponseString JSONValue];
    
    NSArray *configData = [loginAuthenticationResponse valueForKey:@"results"];
    
    [HUD hide:YES];
    
    for (id config in configData)
    {
        version = [config valueForKey:@"version"];
    }
    
   NSString *lVersions = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    //Check your version with the version in app store
    if (![version isEqualToString:lVersions] && ![version isEqualToString:@""])
    {
        
        UIAlertView *A = [[UIAlertView alloc] initWithTitle:@"更新提示" message:@"当前应用检查到新的版本，是否立刻升级" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
        A.tag = 100;
        [A show];
        [A release];
    }
}

-(void)viewiTunesStoreUpdate
{
    NSString * URLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",@"578878323"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}


-(void)viewitunesSotreReview
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"578878323"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self viewiTunesStoreUpdate];
        }
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return  dataArr.count ;
    }else {
        return dataArr2.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSString *str;
    NSString *Destr = @"";
    
    if (indexPath.section == 0) {
        str = [dataArr objectAtIndex:indexPath.row];
        
    }else {
        str = [dataArr2 objectAtIndex:indexPath.row];
        if (indexPath.row == 1) {
            Destr = @"ckcanfly@gmail.com";
        }
    }
    cell.textLabel.text = str;
    cell.detailTextLabel.text = Destr;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}


-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
    [HUD release];
    HUD = Nil;
}

#pragma mark NSURLConnection delegate method

//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//	self.backData = [NSMutableData data];
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//	[backData appendData:data];
//    
//    NSString *aString = [[NSString alloc]initWithData:backData encoding:NSUTF8StringEncoding];
//    
//	NSLog(@"%@",aString);
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSString *err = [error localizedDescription];
//    //    NSLog(err);
//}


//-(void)update
//{
//    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@&entity=software",@"网易新闻"];
//    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    
//	NSURL *url = [NSURL URLWithString:urlString];
//	
//	NSMutableURLRequest *urlRequest =[[NSMutableURLRequest alloc] init];
//	[urlRequest setURL:url];
//	
//	[urlRequest setHTTPMethod:@"POST"];
//	
//	NSURLConnection *urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
//	NSAssert(urlConn != nil, @"Failure to create URL connection.");
//}

#pragma mark - Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"关于豆评";
    }else{
        return @"关于我";

    }
    
}
// custom view for header. will be adjusted to default or specified header height
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0://第一块{
        {
            switch (indexPath.row) {
                case 0:{
                    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"关于豆评论" message:@"本应用主要是一款可以帮你摘录和推荐一些豆瓣精彩评论的阅读工具.评论Top20是选取豆瓣推荐的评论列表,书影音搜索可以帮组你找到你想要的阅读的资源以及对应的热门评论,广播部分则是简化原本广播功能，只摘取了您关注的用户的最近在读的，看的以及听的内容，同时可以跳转搜索获取相应的评论资源." delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [a show];
                    [a release];
                    break;
                }
                    
                case 1:
                    [self checkVersion];
                    break;
                case 2:
                    [self viewitunesSotreReview];
                    break;
            }
            break;
        }
            
            
        case 1://第二块
        {
            switch (indexPath.row) {
                case 0://关于我
                {
                    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"关于我" message:@"宅生梦死,生平不详." delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [a show];
                    [a release];

                    break;
                }
                case 1://意见反馈
                {
                    [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:@"mailto:ckcanfly@gmail.com"]];
                    break;
                }
                    
            }
        }
            
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

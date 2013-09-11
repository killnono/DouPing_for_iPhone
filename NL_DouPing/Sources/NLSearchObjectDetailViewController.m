//
//  NLSearchObjectDetailViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-6.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLSearchObjectDetailViewController.h"
#import "NLDouban.h"
#import "NLSearchMovieData.h"
#import "NLModelObject.h"
#import "UIImageView+NLDispatchLoadImage.h"
#import "NLMoreReviewViewController.h"
#import "NLBookReview.h"
#import "NLMusicReviewData.h"
#import "NLAppDelegate.h"
@interface NLSearchObjectDetailViewController ()
{
    NSString *objectID;
    MBProgressHUD *HUD;
}
@property(nonatomic,retain)NLDouban *db;
@property(nonatomic,retain)NLSearchMovieData *data;
@property(nonatomic,retain)NLBookReview *bdata;
@property(nonatomic,retain)NLMusicReviewData *mdata;
@end

@implementation NLSearchObjectDetailViewController
@synthesize titleLa;
@synthesize imageV;
@synthesize imageACV;
@synthesize gradeLa;
@synthesize directLa;
@synthesize pubTimeLa;
@synthesize castLa;
@synthesize summaryTV,urlID,db,data,tag,bdata,mdata;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) fetachDetail
{
    if (![NLAppDelegate shareAPPDelegate].isAvailableNet) {
        UIAlertView * a = [[ UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误，请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
        [a release];
        return;
    }
    
    
    self.db = [[NLDouban alloc] init];
    [db release];
    
    if ([@"book" isEqualToString:tag]) {
        self.bdata = [[NLBookReview alloc] init];
        [bdata release];
    }else if ([@"movie" isEqualToString:tag])
    {
        self.data = [[NLSearchMovieData alloc] init];
        [data release];
    }else if ([@"music" isEqualToString:tag]){
        self.mdata = [[NLMusicReviewData alloc] init];
        [data release];
    }
    
    [self.imageACV startAnimating];
    [db searchMovieInfotWithAPI:urlID delegate:self];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iPhone5) {
        CGRect mainRect = self.view.frame;
        mainRect.size.height = 504;
        self.view.frame = mainRect;
        
        
        CGRect imageRect = self.imageV.frame;
        imageRect.size.height = 91;
        self.imageV.frame = imageRect;
        
        
        CGRect tvRect = self.summaryTV.frame;
        tvRect.size.height += 88;
        self.summaryTV.frame = tvRect;
    }
   
    
    if(![tag isEqualToString:@"movie"]){
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"看评论" style:UIBarButtonItemStyleBordered target:self action:@selector(moreReviews)];
    self.navigationItem.rightBarButtonItem = btnItem;
    [btnItem release];
    }
    [self fetachDetail];
    // Do any additional setup after loading the view from its nib.
}


-(void)moreReviews
{
    NLMoreReviewViewController *vc = [[NLMoreReviewViewController alloc] init];
    vc.objectID = objectID;
    vc.image = imageV.image;
    vc.tag = tag;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}
-(void) fillContent
{
    if ([@"movie" isEqualToString:tag]) {
        objectID = data.urlID;
        self.titleLa.text = data.title;
        [imageV setImageFromUrl:data.imageURl];
        gradeLa.text = data.garde;
        directLa.text = data.author;        
        castLa.text = [NSString stringWithFormat:@"主演:%@",data.cast];

        summaryTV.text = data.summary;
        pubTimeLa.text = data.pubTime;
    }else if ([@"book" isEqualToString:tag]){
        objectID = bdata.urlID;

        self.titleLa.text = bdata.title;
        [imageV setImageFromUrl:bdata.imageURl];
        gradeLa.text = bdata.garde;
        directLa.text = bdata.author;
        castLa.text = bdata.author_intro;
        summaryTV.text = bdata.summary;
        pubTimeLa.text = bdata.pubTime;
    }else if ([@"music" isEqualToString:tag]){
        objectID = mdata.urlID;
        
        self.titleLa.text = mdata.title;
        [imageV setImageFromUrl:mdata.imageURl];
        gradeLa.text = mdata.garde;
        directLa.text = mdata.author;
        castLa.text = [NSString stringWithFormat:@"Tags:%@",mdata.tags];
        summaryTV.text = mdata.summary;
        pubTimeLa.text = mdata.pubTime;
    }
   
}
- (void)viewDidUnload
{
    [self setGradeLa:nil];
    [self setDirectLa:nil];
    [self setPubTimeLa:nil];
    [self setCastLa:nil];
    [self setSummaryTV:nil];
    [self setImageV:nil];
    [self setTitleLa:nil];
    [self setImageACV:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    [self.imageACV stopAnimating];

    if (code == 200) {
        if ([@"movie" isEqualToString:tag]) {
          [self.data jsonString2Bean:response];  
        }else if([@"book" isEqualToString:tag]){
            [self.bdata jsonString2Bean:response];
        }else if([@"music" isEqualToString:tag]){
            [self.mdata jsonString2Bean:response];
        }
        
        [self fillContent];
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [mdata release];
    [bdata release];
    [tag release];
    [data release];
    [db release];
    [urlID release];
    [gradeLa release];
    [directLa release];
    [pubTimeLa release];
    [castLa release];
    [summaryTV release];
    [imageV release];
    [titleLa release];
    [imageACV release];
    [super dealloc];
}
@end

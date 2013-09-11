//
//  NLReviewViewController.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-2.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidingTabsControl.h"
#import "NLDouban.h"
#import "MBProgressHUD.h"
#import "GADBannerViewDelegate.h"
@interface NLReviewViewController : UIViewController<SlidingTabsControlDelegate,UITableViewDelegate,UITableViewDataSource,NLDoubanRequestDelegate,NSXMLParserDelegate,MBProgressHUDDelegate,GADBannerViewDelegate>
{
    NSString *currentTAG;
    MBProgressHUD *HUD;

    UITableView *tabV;
    
    NSMutableArray *dataArr;
    
    NSMutableArray *parserObjects;
    NSMutableDictionary *twitterDic;
    
    NLDouban *douban;
    int intTag;
}
@property(retain,nonatomic)NSMutableArray *dataArr;
@property(retain,nonatomic)NLDouban *douban;
@end

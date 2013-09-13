//
//  NLMoreReviewViewController.h
//  豆瓣骚年
//
//  Created by 陈 凯 on 12-11-12.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "NLDouban.h"
#import "NLBaseResizeViewController.h"
@interface NLMoreReviewViewController : NLBaseResizeViewController<NLDoubanRequestDelegate,UITableViewDelegate,UITableViewDataSource,NLDoubanRequestDelegate,NSXMLParserDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    
    UITableView *tabV;
    
    NSMutableArray *dataArr;
    
    NSMutableArray *parserObjects;
    NSMutableDictionary *twitterDic;
    
    NLDouban *douban;

}
@property(retain,nonatomic)NSMutableArray *dataArr;
@property(retain,nonatomic)NLDouban *douban;
@property(retain , nonatomic) NSString *objectID;
@property(retain , nonatomic) NSString *tag;

@property (retain ,nonatomic) UIImage *image;
@end

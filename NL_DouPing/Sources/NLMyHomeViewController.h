//
//  NLMyHomeViewController.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-30.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLUserInfoView.h"
#import "NLDouban.h"
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
#import "NLBaseResizeViewController.h"
@class NLFriendsShuoShuoData;
@interface NLMyHomeViewController : NLBaseResizeViewController<UITableViewDelegate,UITableViewDataSource,NLDoubanRequestDelegate,EGORefreshTableHeaderDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    UITableView *tabV;
    NLUserInfoView *contentView;
    
    EGORefreshTableHeaderView *refresView;
    NSMutableArray *miniArr;
    BOOL isLoading;
    
}
@property (retain, nonatomic) IBOutlet UITableViewCell *Tabcell;
@property(retain,nonatomic)UITableView *tabV;
@property(retain,nonatomic)NLUserInfoView *contentView;
@property(retain,nonatomic)NSMutableArray *miniArr;
@property(retain,nonatomic) EGORefreshTableHeaderView *refresView;
@end

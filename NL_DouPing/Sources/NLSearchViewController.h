//
//  NLSearchViewController.h
//  豆瓣骚年
//
//  Created by Nono on 12-11-4.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLDouban.h"
#import "MBProgressHUD.h"
#import "NLFriendShareInfo.h"
#import "NLBaseResizeViewController.h"
@interface NLSearchViewController : NLBaseResizeViewController<UISearchBarDelegate,NLDoubanRequestDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>


@property (retain, nonatomic) IBOutlet UISegmentedControl *seg;
@property (retain, nonatomic) IBOutlet UITableView *tav;
@property (retain, nonatomic) IBOutlet UISearchBar *sb;
@property (retain, nonatomic) NLFriendShareInfo *_info;
- (IBAction)segChange:(id)sender;

@end

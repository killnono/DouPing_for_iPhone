//
//  NLSearchObjectDetailViewController.h
//  豆瓣骚年
//
//  Created by Nono on 12-11-6.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLDouban.h"
#import "MBProgressHUD.h"
#import "NLBaseResizeViewController.h"
@interface NLSearchObjectDetailViewController : NLBaseResizeViewController<NLDoubanRequestDelegate,MBProgressHUDDelegate>
@property (retain, nonatomic) IBOutlet UILabel *titleLa;
@property (retain, nonatomic) IBOutlet UIImageView *imageV;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *imageACV;

@property (nonatomic,retain)NSString *urlID;
@property (nonatomic,retain)NSString *tag;

@property (retain, nonatomic) IBOutlet UILabel *gradeLa;
@property (retain, nonatomic) IBOutlet UILabel *directLa;
@property (retain, nonatomic) IBOutlet UILabel *pubTimeLa;
@property (retain, nonatomic) IBOutlet UILabel *castLa;
@property (retain, nonatomic) IBOutlet UITextView *summaryTV;

@end

//
//  NLReviewDetailViewController.h
//  豆瓣骚年
//
//  Created by Nono on 12-8-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLDouban.h"
#import "GADBannerViewDelegate.h"
@interface NLReviewDetailViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate,GADBannerViewDelegate>

{
    NSString *reviewId;
    NLDouban *douban;
    UIWebView *webView;
    
    
}
@property(retain,nonatomic)NSString *reviewId;
@property(retain,nonatomic) NLDouban *douban;
@property(retain,nonatomic) UIWebView *webView;
@end

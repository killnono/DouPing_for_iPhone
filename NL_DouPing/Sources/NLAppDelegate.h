//
//  NLAppDelegate.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-29.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface NLAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    BOOL isAvailableNet;
    Reachability *hostReachability;
    BOOL isLogin;
    NSString *token;
}

+(NLAppDelegate*)shareAppDelegate;
@property(nonatomic,assign) BOOL isAvailableNet;
@property(nonatomic,assign)BOOL isLogin;
@property (retain,nonatomic)UINavigationController *nav;
@property (strong, nonatomic) UIWindow *window;
@property(retain,nonatomic)NSString *token;

+(NLAppDelegate*)shareAPPDelegate;
@end

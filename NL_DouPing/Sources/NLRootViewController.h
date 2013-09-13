//
//  NLRootViewController.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-29.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLAppDelegate.h"
#import "GradientButton.h"
#import "NLBaseResizeViewController.h"

@interface NLRootViewController : NLBaseResizeViewController

{
    NLAppDelegate *_delegate;
    
    GradientButton *loginBtn;
    
}
@end

//
//  NLBaseResizeViewController.m
//  NL_DouPing
//
//  Created by 陈 凯 on 13-9-11.
//  Copyright (c) 2013年 Nono. All rights reserved.
//

#import "NLBaseResizeViewController.h"


//if ( IOS7_OR_LATER )
//{
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
//}
//#endif	// #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
@interface NLBaseResizeViewController ()

@end

@implementation NLBaseResizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    ;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {

//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IOS7_OR_LATER) {
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
//        self.modalPresentationCapturesStatusBarAppearance = NO;
//        self.extendedLayoutIncludesOpaqueBars = NO;

    }
    }
//#endif	// #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

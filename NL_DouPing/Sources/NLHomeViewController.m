//
//  NLHomeViewController.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-29.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLHomeViewController.h"

@interface NLHomeViewController ()

@end

@implementation NLHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:1];
        
        self.tabBarItem = theItem;
         [theItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeInfoDark];
    test.frame = CGRectMake(20, 20, 40, 40);
    [self.view addSubview:test];
    
    self.navigationController.title = @"Home";
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

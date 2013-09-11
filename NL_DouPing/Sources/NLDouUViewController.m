//
//  NLDouUViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-14.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLDouUViewController.h"
#import "MBProgressHUD.h"
@interface NLDouUViewController ()
{
    UISearchBar *sb;
    UISegmentedControl *seg;
}
@property(retain,nonatomic)NLDouban *db;

@end

@implementation NLDouUViewController
@synthesize db;
- (void)dealloc
{
    [db release];
    [super dealloc];
}

-(void)fetchObject
{
    self.db = [[NLDouban alloc]init];
    [db release];
    [db searchObjectWithTag:@"movie" key:@"蜘蛛侠" delegate:self];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"书影音搜索";
    NSArray *a = [[NSArray alloc] initWithObjects:@"书籍",@"电影",@"音乐",nil];
    seg = [[UISegmentedControl alloc] initWithItems:a];
    seg.frame = CGRectMake(0, 0, 320, 40);
    [seg setSegmentedControlStyle:UISegmentedControlStyleBordered];
    [self.view addSubview:seg];
    
    sb = [[UISearchBar alloc] init];
    sb.frame = CGRectMake(0, 40, 320, 40);
    [self.view addSubview:sb];
	// Do any additional setup after loading the view.
    [self fetchObject];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
//    [HUD hide:YES afterDelay:0.5];
    if (code == 200) {
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

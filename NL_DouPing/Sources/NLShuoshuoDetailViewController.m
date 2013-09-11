//
//  NLShuoshuoDetailViewController.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-23.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLShuoshuoDetailViewController.h"
@interface NLShuoshuoDetailViewController ()
@property(retain,nonatomic)NLDouban *douban;
@end

@implementation NLShuoshuoDetailViewController
@synthesize douban;

- (void)dealloc
{
    [douban release];
    [super dealloc];
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
    
    self.douban = [[NLDouban alloc]init];
    [douban SingleShuoshuo:@"993522367" delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)handleReponse:(NSString*)response ResponseStatusCode:(int)code
{
    if (code == 200) {
        
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

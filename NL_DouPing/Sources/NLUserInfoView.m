//
//  NLUserInfoView.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLUserInfoView.h"

@implementation NLUserInfoView
@synthesize nameLabel,image,addressLabel,contentLabel,douULabel;

- (void)dealloc
{
    [nameLabel release];
    [image release];
    [addressLabel release];
    [contentLabel release];
    [douULabel release];
    [super dealloc];
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSLog(@"提交测试");
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
        self.image = imv;
        [imv release];
        [self addSubview:image];
        
        UILabel *la1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 35)];
        self.addressLabel = la1;
        la1.backgroundColor = [UIColor clearColor];
        [la1 release];
        [self addSubview:addressLabel];
        
        
        UILabel *la2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, 200, 35)];
        la2.backgroundColor = [UIColor clearColor];
        self.nameLabel = la2;
        [la2 release];
        [self addSubview:nameLabel];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

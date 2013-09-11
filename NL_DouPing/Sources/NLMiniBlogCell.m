//
//  NLMiniBlogCell.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLMiniBlogCell.h"
#import "NonoConfig.h"
@implementation NLMiniBlogCell
@synthesize imageV,title,text,who,short_title,content,contentGg;

- (void)dealloc
{
    [imageV release];
    [text release];
    [title release];
    [content release];
    [who release];
    [contentGg release];
    [short_title release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = [UIColor whiteColor];
        
        // Initialization code
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        [self.contentView addSubview:imageV];
        [imageV release];
      
        self.who = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 100, 20)];
        who.font = [UIFont systemFontOfSize:13];
        who.backgroundColor = [UIColor clearColor];
        who.textColor = CustomColor_Ligth_Blue;
        [self.contentView addSubview:who];
        [who release];
        
        self.short_title = [[UILabel alloc]initWithFrame:CGRectMake(145, 10, 40, 20)];  
        short_title.backgroundColor = [UIColor clearColor];
        short_title.font = [UIFont systemFontOfSize:12];
        short_title.textColor = [UIColor brownColor];
        [self.contentView addSubview:short_title];
        [short_title release];
        
        self.contentGg = [[UIImageView alloc] initWithFrame:CGRectZero];
        contentGg.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:224.0/255.0 blue:230.0/255.0 alpha:0.7];
        [self.contentView addSubview:contentGg];
        [contentGg release];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:14];
        title.numberOfLines =0; 
        title.lineBreakMode = UILineBreakModeWordWrap;
        [self.contentView addSubview:title];
        [title release];
        
        
        self.content = [[UILabel alloc]initWithFrame:CGRectMake(145, 10, 40, 20)];  
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:12];
        content.numberOfLines =0;
        content.lineBreakMode = UILineBreakModeWordWrap;
        content.textColor = [UIColor grayColor];
        [self.contentView addSubview:content];
        [content release];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        text.font = [UIFont systemFontOfSize:13];
        text.numberOfLines =0; 
        text.lineBreakMode = UILineBreakModeWordWrap;
        text.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:text];
        [text release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

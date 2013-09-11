//
//  NLReviewCell.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-3.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLReviewCell.h"

@implementation NLReviewCell
@synthesize title,Time,who,content,imageV;

- (void)dealloc
{
    [imageV release];
    [content release];
    [Time release];
    [title release];
    [who release];
    [super dealloc];
}
-(void)restAllView
{
    self.title.text = nil;
    self.who.text = nil;
    self.content.text = nil;
    self.Time.text = nil;
    UIImage *img = [UIImage imageNamed:@"loading80*120.png"];
    [imageV setImage:img];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.contentView.backgroundColor = [UIColor darkGrayColor];
        // Initialization code
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 80)];
        UIImage *img = [UIImage imageNamed:@"loading80*120.png"];
        [imageV setImage:img];
        [self.contentView addSubview:imageV];
        [imageV release];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 220, 40)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:14];
        title.numberOfLines =0; //this is used to determine how many lines this label will have.if =3,it means this  label's text will show 3 lines.if =0 ,it means that this label's text will show the line whate it needs.no limit.
        title.lineBreakMode = UILineBreakModeWordWrap;// sys will change the line by word.aslo can be by character  for another value. 
        [self.contentView addSubview:title];
        [title release];
        
        UILabel *whoLa = [[UILabel alloc]initWithFrame:CGRectMake(80, 55, 30, 20)];
        whoLa.text = @"作者:";
        whoLa.backgroundColor = [UIColor clearColor];
        whoLa.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:whoLa];
        [whoLa release];
        
        self.who = [[UILabel alloc]initWithFrame:CGRectMake(112, 55, 150, 20)];
        who.backgroundColor = [UIColor clearColor];
        who.font = [UIFont systemFontOfSize:13];
        who.textColor = [UIColor redColor];
        [self.contentView addSubview:who];
        [who release];
        
        
        self.content = [[UILabel alloc]initWithFrame:CGRectMake(20, 95, 280, 85)];
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:12];
        content.numberOfLines =0; //this is used to determine how many lines this label will have.if =3,it means this  label's text will show 3 lines.if =0 ,it means that this label's text will show the line whate it needs.no limit.
        content.lineBreakMode = UILineBreakModeWordWrap;// sys will change the line by word.aslo can be by character  for another value. 
        [self.contentView addSubview:content];
        [content release];
        
   
        
        
        self.Time = [[UILabel alloc]initWithFrame:CGRectMake(150, 180, 150, 20)];
        Time.backgroundColor = [UIColor clearColor];
        Time.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:Time];
        [Time release];

        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

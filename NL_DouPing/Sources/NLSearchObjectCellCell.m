//
//  NLSearchObjectCellCell.m
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLSearchObjectCellCell.h"

@implementation NLSearchObjectCellCell
@synthesize title,who,content,imageV;

- (void)dealloc
{
    [title release];
    [who release];
    [content release];
    [imageV release];
    [super dealloc];
}

-(void)restAllView
{
    self.title.text = nil;
    self.who.text = nil;
    self.content.text = nil;
    UIImage *img = [UIImage imageNamed:@"loading80*120.png"];
    [imageV setImage:img];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                self.contentView.backgroundColor = [UIColor clearColor];
        // Initialization code
        self.imageV=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 80)];
        UIImage *img = [UIImage imageNamed:@"loading80*120.png"];
        [imageV setImage:img];
        [self.contentView addSubview:imageV];
        [imageV release];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 25)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self.contentView addSubview:title];
        [title release];

        
        
        self.content = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 220, 40)];
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:14];
//        content.textColor = [UIColor whiteColor];

        content.numberOfLines =2; //this is used to determine how many lines this label will have.if =3,it means this  label's text will show 3 lines.if =0 ,it means that this label's text will show the line whate it needs.no limit.
        [self.contentView addSubview:content];
        [content release];
        
        
        
        
        self.who = [[UILabel alloc]initWithFrame:CGRectMake(150, 80, 150, 15)];
        who.backgroundColor = [UIColor clearColor];
        who.font = [UIFont systemFontOfSize:12];
        who.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:who];
        [who release];
        
        
        
        
    }
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

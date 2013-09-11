//
//  NLFriendsShuoCell.m
//  豆瓣骚年
//
//  Created by Nono on 12-8-18.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "NLFriendsShuoCell.h"

@implementation NLFriendsShuoCell
@synthesize imageV,title,Time,who;

- (void)dealloc
{
    [imageV release];
    [Time release];
    [title release];
    [who release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

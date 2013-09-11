//
//  NLFriendsShuoCell.h
//  豆瓣骚年
//
//  Created by Nono on 12-8-18.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLFriendsShuoCell : UITableViewCell
{
    UIImageView * imageV;//图片
    UILabel * Time;//时间
    UILabel * who;//期次;
    UILabel *title;
}
@property(nonatomic,retain)UIImageView * imageV;
@property(nonatomic,retain)UILabel * Time;
@property(nonatomic,retain)UILabel * who;
@property(nonatomic,retain)UILabel *title;
@end

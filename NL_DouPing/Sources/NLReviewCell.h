//
//  NLReviewCell.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-3.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLReviewCell : UITableViewCell
{
    UIImageView * imageV;//图片
    UILabel * Time;//时间
    UILabel * who;//期次;
    UILabel *title;//
    UILabel *content;
}

-(void)restAllView;
@property(nonatomic,retain)UIImageView * imageV;
@property(nonatomic,retain)UILabel * Time;
@property(nonatomic,retain)UILabel * who;
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel *content;
@end

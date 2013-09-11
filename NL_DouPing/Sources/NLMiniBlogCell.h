//
//  NLMiniBlogCell.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLMiniBlogCell : UITableViewCell
{
    UIImageView * imageV;//图片
    UILabel * who;
    UILabel * short_title;

    UILabel * text;
  
    UILabel *title;
    UILabel *content;
    
    UIImageView *contentGg;
    
    
}
@property(nonatomic,retain)UIImageView * imageV;
@property(nonatomic,retain)UILabel * text;
@property(nonatomic,retain)UILabel * who;
@property(nonatomic,retain)UILabel *title;
@property(nonatomic,retain)UILabel * short_title;
@property(nonatomic,retain)UILabel *content;
@property(nonatomic,retain)UIImageView *contentGg;

@end

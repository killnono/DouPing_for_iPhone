//
//  NLSearchObjectCellCell.h
//  豆瓣骚年
//
//  Created by Nono on 12-11-5.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLSearchObjectCellCell : UITableViewCell
-(void)restAllView;

@property(nonatomic,retain)UIImageView * imageV;
@property(nonatomic,retain)UILabel * content;
@property(nonatomic,retain)UILabel * who;
@property(nonatomic,retain)UILabel *title;
@end

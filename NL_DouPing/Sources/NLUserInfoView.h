//
//  NLUserInfoView.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-7-31.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NLUserInfoView : UIView

{
    UIImageView *image;
    UILabel *addressLabel;
    UILabel *nameLabel;
    UILabel *douULabel;
    UITextView *contentLabel;
}
@property(retain,nonatomic)UIImageView *image;
@property(retain,nonatomic)UILabel *addressLabel;
@property(retain,nonatomic)UILabel *nameLabel;
@property(retain,nonatomic)UILabel *douULabel;
@property(retain,nonatomic)UITextView *contentLabel;
@end

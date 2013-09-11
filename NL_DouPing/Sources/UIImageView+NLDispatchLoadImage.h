//
//  UIImageView+NLDispatchLoadImage.h
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-3.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NLDispatchLoadImage)

- (void) setImageFromUrl:(NSString*)urlString;
- (void) setImageFromUrl:(NSString*)urlString 
              completion:(void (^)(void))completion;
@end

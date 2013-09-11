//
//  UIImageView+NLDispatchLoadImage.m
//  豆瓣For文艺青年
//
//  Created by Nono on 12-8-3.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

#import "UIImageView+NLDispatchLoadImage.h"

@implementation UIImageView (NLDispatchLoadImage)
- (void) setImageFromUrl:(NSString*)urlString {
    
    
    [self setImageFromUrl:urlString completion:NULL];
}
- (void) setImageFromUrl:(NSString*)urlString 
              completion:(void (^)(void))completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *avatarImage = nil;
    
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        avatarImage = [UIImage imageWithData:responseData];
        
        if (avatarImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = avatarImage;
               
            });
        }
        else {
          //  NSLog(@"-- impossible download: %@", urlString);
        }
//        dispatch_async(dispatch_get_main_queue(), completion);

    });   
}
@end

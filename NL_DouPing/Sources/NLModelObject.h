//
//  NLModelObject.h
//  iPhoneCommon
//
//  Created by Nono on 12-6-7.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//
/****模型对象基类，类似于javaBean角色****/
#import <Foundation/Foundation.h>
@interface NSObject (NLModeObject)

/**
 step 1:构造一个字典，将bean中属性值设置进去
 step 2:调用 jsonValue方法将dic生成一窜json格式字窜
 */

- (NSString *)bean2jsonString;

//将json字窜格式转化成dic在复制成bean形式
- (void)jsonString2Bean:(NSString *) jsonString;

//- (NSString *)getMethidCode;


@end

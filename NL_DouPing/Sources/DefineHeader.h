//
//  DefineHeader.h
//  豆瓣骚年
//
//  Created by Nono on 12-11-9.
//  Copyright (c) 2012年 NonoWithLilith. All rights reserved.
//

//常用的宏
#ifndef _____DefineHeader_h
#define _____DefineHeader_h

//admob
#define ADBMOB_ID @"a15177d9c8ada9c"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//是否是ios7以后的系统
#define IOS7_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) ? YES:NO)



//release屏蔽NSLog
//放在.pch文件里
#ifdef DEBUG

#else
#define NSLog(...) {};
#endif



//G。C。D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


//Device
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//区分模拟器和真机

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#endif

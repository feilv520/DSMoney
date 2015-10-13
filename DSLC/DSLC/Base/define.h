//
//  define.h
//  DSLC
//
//  Created by 马成铭 on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#ifndef define_h
#define define_h

//判定系统版本
#define IOSVersion [[UIDevice currentDevice].systemVersion doubleValue]
#define IS_IOS6 [[[UIDevice currentDevice] systemVersion] floatValue]<7.0
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0

#define WIDTH_VIEW_DEFAULT   self.frame.size.width
#define HEIGHT_VIEW_DEFAULT   self.frame.size.height
#define WIDTH_CONTROLLER_DEFAULT   [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_CONTROLLER_DEFAULT   ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?[[UIScreen mainScreen] bounds].size.height+20:[[UIScreen mainScreen] bounds].size.height)
//判断是否6plus 键盘高度不一样
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

//颜色
#define Color_Black [UIColor blackColor]
#define Color_White  [UIColor whiteColor]
#define Color_Clear  [UIColor clearColor]
#define Color_Red [UIColor redColor]

//主要颜色
#define mainColor [UIColor colorWithRed:239.0 / 255.0 green:241.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];

#endif /* Header_h */
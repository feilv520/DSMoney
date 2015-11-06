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
#define mainColor [UIColor colorWithRed:239.0 / 255.0 green:241.0 / 255.0 blue:243.0 / 255.0 alpha:1.0]
#define mainRedColor [UIColor colorWithRed:221.0 / 255.0 green:75.0 / 255.0 blue:72.0 / 255.0 alpha:1.0]
#define buttonBorderColor [UIColor colorWithRed:226.0 / 255.0 green:226.0 / 255.0 blue:226.0 / 255.0 alpha:1]
#define Color_Gray [UIColor colorWithRed:235 / 255.0 green:237 / 255.0 blue:240 / 255.0 alpha:1.0]
#define TabelVie_Color_Gray [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:226 / 255.0 alpha:1.0]

//导航栏方法

#define pushVC(viewController) [self.navigationController pushViewController:viewController animated:YES]
#define popVC [self.navigationController popViewControllerAnimated:YES]

#import "FileOfManage.h"
#import "ProgressHUD.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "MyAfHTTPClient.h"

#endif /* Header_h */

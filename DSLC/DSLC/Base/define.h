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
#define WIDTH_CVIEW_DEFAULT   self.view.frame.size.width
#define HEIGHT_CVIEW_DEFAULT  self.view.frame.size.height
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

// 判断系统
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define ZT @"冬青黑体"

#define PIE_HEIGHT 280

#import "FileOfManage.h"                     // 文件管理类
#import "ProgressHUD.h"                      // 提示框的第三方
#import "UIColor+AddColor.h"                 // 颜色类目
#import "CreatView.h"                        // 创建控件类
#import "TPKeyboardAvoidingScrollView.h"     // 自适应键盘类
#import "AFNetworking.h"                     // AFN网络请求
#import "AFHTTPSessionManager.h"             // AFN网络请求
#import "MyAfHTTPClient.h"                   // 网络请求
#import "MBProgressHUD.h"                    // 提示框
#import "NSString+Check.h"                   // 检验的类目
#import "CJNavigationController.h"           // CJ导航栏类
#import "MJRefresh.h"                        // 第三方刷新类
#import "UIViewController+Loading.h"         // 试图控制器的类目
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
#import "DES3Util.h"                         // 加密
#import "NSString+Check.h"                   // 字符串检查
#import "UMSocial.h"                         // 友盟分享
#import "UMSocialWechatHandler.h"            // 微信分享
#import "UMSocialQQHandler.h"                // QQ分享
#import "YYWebImage.h"                       // 异步图片加载框架
#import "MobClick.h"                         // 友盟统计插件
#import "JSONKit.h"                          // 第三方解析库
#import "LLPaySdk.h"                         // 连连支付
#import "LLPayUtil.h"                        // 连连文件
#import "NSString+md5String.h"               // md5加密
#import "JPUSHService.h"                     // 激光推送

static NSString *kLLOidPartner = @"201512161000642725";   // 商户号
static NSString *kLLPartnerKey = @"gcctdslc20151231_20160101";   // 密钥

//2.0 测试接口
//static NSString * MYAFHTTP_BASEURL = @"http://192.168.0.161:8083/dslc/interface/";
//static NSString * MYAFHTTP_BASEURL = @"http://192.168.0.75:8080/dslc/interface/";
//static NSString * MYAFHTTP_BASEURL = @"http://192.168.0.14:8080/dslc/interface/";

//2.0线上测试接口地址
//static NSString * MYAFHTTP_BASEURL = @"http://61.172.238.245:8000/dslc/interface/";

//2.0正是环境
static NSString * MYAFHTTP_BASEURL = @"http://interface.dslc.cn/dslc/interface/";

//2.0 H5接口
//测试
//static NSString *htmlFive = @"http://192.168.0.161:8088/zhongxin";

//线上测试
//static NSString *htmlFive = @"http://www.zrgyjt.com:8000";
//static NSString *htmlFive = @"http://waptest.dslc.cn";

//正式环境
static NSString *htmlFive = @"http://wap.dslc.cn";

//外网测试接口
//static NSString *htmlFive = @"http://www.zrgyjt.com";

#endif /* Header_h */

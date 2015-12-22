//
//  BaseViewController.h
//  DSLC
//
//  Created by 马成铭 on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "CreatView.h"

@interface BaseViewController : UIViewController <LLPaySdkDelegate>

@property (nonatomic, strong) NSDictionary *flagDic;
@property (nonatomic, strong) UIImageView *imageReturn;

- (void)setTitleString:(NSString *)titleString;

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar;

@end

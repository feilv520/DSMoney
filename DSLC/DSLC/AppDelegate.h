//
//  AppDelegate.h
//  DSLC
//
//  Created by 马成铭 on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTabBarViewController.h"

static NSString *appKey = @"f3130cec9a6c22b50f8c44ee";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) KKTabBarViewController *tabBarVC;
@property (nonatomic, strong) NSArray *viewControllerArr;

@end


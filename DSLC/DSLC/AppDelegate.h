//
//  AppDelegate.h
//  DSLC
//
//  Created by 马成铭 on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) KKTabBarViewController *tabBarVC;
@property (nonatomic, strong) NSArray *viewControllerArr;

@end


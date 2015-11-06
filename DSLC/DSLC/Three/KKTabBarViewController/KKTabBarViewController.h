//
//  KKTabBarViewController.h
//  KKTabBarViewDemo
//
//  Created by yaodd on 14-1-26.
//  Copyright (c) 2014年 yaodd. All rights reserved.
//
//  带滑动手势的tabBarViewController，可自定义tabBar，只需要传入自己自定义的UIButton数组即可，

#import "ViewController.h"
typedef NS_ENUM(NSInteger, TabBarPosition){
    kTabBarPositionTop,
    kTabBarPositionBottom
};

@interface KKTabBarViewController : ViewController <UIScrollViewDelegate>
@property (nonatomic, assign) int curPage;                              //当前选中的页面
@property (nonatomic, assign) BOOL tabBarHidden;                        //是否隐藏底部的tabBar
@property (nonatomic, assign) BOOL transitionAnimated;                  //点击tabBar是否有滑动翻页效果
@property (nonatomic, assign) BOOL suppurtGestureTransition;            //是否支持手势滑动
@property (nonatomic, assign) CGFloat tabBarHeight;                     //tabBar的高度，意味着可在非初始化时修改tabBar的高度
@property (nonatomic, strong) NSArray *controllerArray;                 //controller的数组
@property (nonatomic, strong) NSArray *tabButtonArray;                  //底部tabBar的数组，为自定义button
@property (nonatomic, assign) TabBarPosition tabBarPosition;            //tabBar的位置，可选底部和顶部，默认底部
@property (nonatomic, strong) UILabel *labelLine;

@property (nonatomic, strong) UIScrollView *tabScrollView;

// 带参数的初始化函数
- (id)initWithControllerArray:(NSArray *)controllerArray;
// 设置是否隐藏掉切换页面的按钮
- (void)setTabBarHidden:(BOOL)tabBarHidden;

- (void)setLabelLineHidden:(BOOL)LabelLineHidden;

- (void)setTabbarViewHidden:(BOOL)tabbarViewHidden;

@end

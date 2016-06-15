//
//  LYCircleView.h
//  LYCircleView
//
//  Created by user on 16/5/30.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYCircleViewDataSource <NSObject>

@required
/**
 圆饼百分比
 */
- (NSArray *)percentOfTheCircle;

@optional
/**
 颜色与百分比一一对应
 */
- (NSArray *)hexStringOfCircleColor;

/**
 显示的内容
 */
- (NSArray *)textStringOfCircle;

@end

@interface LYCircleView : UIView

@property (nonatomic, weak)id <LYCircleViewDataSource>dataSource;

///更新数据
- (void)reloadData;

@end

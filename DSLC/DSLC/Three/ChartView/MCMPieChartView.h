//
//  PieChartView.h
//  Statements
//
//  Created by Moncter8 on 13-5-30.
//  Copyright (c) 2013年 Moncter8. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMRotatedView.h"

@class MCMPieChartView;
@protocol PieChartDelegate <NSObject>
@optional
- (void)selectedFinish:(MCMPieChartView *)pieChartView index:(NSInteger)index percent:(float)per;
- (void)onCenterClick:(MCMPieChartView *)PieChartView;
@end

@interface MCMPieChartView : UIView <RotatedViewDelegate>
@property (nonatomic,strong) UIButton *centerView;
@property(nonatomic, assign) id<PieChartDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withValue:(NSMutableArray *)valueArr withColor:(NSMutableArray *)colorArr;
- (void)reloadChart;
- (void)setAmountText:(NSString *)text;
- (void)setTitleText:(NSString *)text;
@end

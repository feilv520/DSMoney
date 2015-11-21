//
//  UIViewController+Loading.h
//  DSLC
//
//  Created by 马成铭 on 15/11/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"


@interface UIViewController (Loading)

// 给tableview添加上拉加载,下拉刷新
- (void)addTableViewWithHeader:(UITableView *)tableview;
- (void)addTableViewWithFooter:(UITableView *)tableview;

// 执行方法
- (void)loadNewData:(MJRefreshGifHeader *)header;
- (void)loadMoreData:(MJRefreshBackGifFooter *)footer;

// 网络数据加载
- (void)loadingWithView:(UIView *)view loadingFlag:(BOOL)loadingFlag height:(CGFloat)height;

// 隐藏方法
- (void)loadingWithHidden:(BOOL)hidden;

// 解密
- (NSString*)decryptUseDES:(NSString*)cipherText;

// 加密
- (NSString *)encryptUseDES:(NSString *)clearText;
@end

//
//  MonkeyViewController.h
//  DSLC
//
//  Created by ios on 16/2/25.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "ProductDetailModel.h"

@interface MonkeyViewController : BaseViewController

@property (nonatomic) BOOL decide;

@property (nonatomic, strong) ProductDetailModel *detailM;
@property (nonatomic, strong) NSString *residueMoney;

@property (nonatomic, strong) NSString *nHand;

@end

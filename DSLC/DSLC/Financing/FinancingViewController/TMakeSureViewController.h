//
//  TMakeSureViewController.h
//  DSLC
//
//  Created by ios on 16/3/15.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDetailModel.h"

@interface TMakeSureViewController : BaseViewController

@property (nonatomic) BOOL decide;

@property (nonatomic, strong) ProductDetailModel *detailM;
@property (nonatomic, strong) NSString *residueMoney;

@property (nonatomic, strong) NSString *nHand;

@end

//
//  TWOProductMakeSureViewController.h
//  DSLC
//
//  Created by 马成铭 on 16/5/11.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDetailModel.h"


@interface TWOProductMakeSureViewController : BaseViewController

@property (nonatomic) BOOL decide;

@property (nonatomic, strong) ProductDetailModel *detailM;

@property (nonatomic, strong) NSString *residueMoney;

@end

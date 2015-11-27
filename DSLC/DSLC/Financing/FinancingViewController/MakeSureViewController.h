//
//  MakeSureViewController.h
//  DSLC
//
//  Created by ios on 15/10/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "ProductDetailModel.h"


@interface MakeSureViewController : BaseViewController

@property (nonatomic) BOOL decide;

@property (nonatomic, strong) ProductDetailModel *detailM;
@property (nonatomic, strong) NSString *residueMoney;

@property (nonatomic, strong) NSString *nHand;

@end

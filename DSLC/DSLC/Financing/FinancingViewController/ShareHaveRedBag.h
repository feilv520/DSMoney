//
//  ShareHaveRedBag.h
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "RedBagModel.h"

@interface ShareHaveRedBag : BaseViewController

@property (nonatomic, strong) RedBagModel *redbagModel;

@property (nonatomic, strong) NSString *nHand;

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *moneyString;
@property (nonatomic, copy) NSString *syString;
@property (nonatomic, copy) NSString *endTimeString;

@property (nonatomic, copy) NSString *monkeyString;

@end

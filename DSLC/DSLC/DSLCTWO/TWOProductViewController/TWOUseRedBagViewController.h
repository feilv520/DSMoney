//
//  TWOUseRedBagViewController.h
//  DSLC
//
//  Created by ios on 16/5/26.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "TWORedBagModel.h"

@interface TWOUseRedBagViewController : BaseViewController

typedef void (^ReturnRedBagBlock)(TWORedBagModel *model);

@property (nonatomic, copy) ReturnRedBagBlock returnRedBagBlock;

- (void)returnText:(ReturnRedBagBlock)block;

@property (nonatomic, strong) NSString *proPeriod;
@property (nonatomic, strong) NSString *transMoney;

@end

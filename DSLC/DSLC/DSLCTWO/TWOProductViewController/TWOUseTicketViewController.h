//
//  TWOUseTicketViewController.h
//  DSLC
//
//  Created by ios on 16/5/26.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "TWOJiaXiQuanModel.h"

@interface TWOUseTicketViewController : BaseViewController

typedef void (^ReturnJiaXiQuanBlock)(TWOJiaXiQuanModel *model);

@property (nonatomic, copy) ReturnJiaXiQuanBlock returnJiaXiQuanBlock;

- (void)returnText:(ReturnJiaXiQuanBlock)block;

@property (nonatomic, strong) NSString *proPeriod;
@property (nonatomic, strong) NSString *transMoney;

@end

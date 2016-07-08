//
//  TWOUseTicketViewController.h
//  DSLC
//
//  Created by ios on 16/5/26.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "BaseViewController.h"

@interface TWOUseTicketViewController : BaseViewController

typedef void (^ReturnTextBlock)(NSString *showText);

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@property (nonatomic, strong) NSString *proPeriod;
@property (nonatomic, strong) NSString *transMoney;

@end

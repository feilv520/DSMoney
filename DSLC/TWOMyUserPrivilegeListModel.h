//
//  TWOMyUserPrivilegeListModel.h
//  DSLC
//
//  Created by 马成铭 on 16/6/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWOMyUserPrivilegeListModel : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *investMoney;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *dueDate;
@property (nonatomic, copy) NSString *exceptedYield;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *annualYield;
@property (nonatomic, copy) NSString *privilegeYield;
@property (nonatomic, copy) NSString *period;

@end

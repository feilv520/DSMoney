//
//  ProductDetailModel.m
//  DSLC
//
//  Created by 马成铭 on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"annualYield"]) {
        self.productAnnualYield = value;
    } else if ([key isEqualToString:@"period"]) {
        self.productPeriod = value;
    } else if ([key isEqualToString:@"yieldDistribTypeName"]) {
        self.productYieldDistribTypeName = value;
    } else if ([key isEqualToString:@"increaseMoney"]) {
        self.amountIncrease = value;
    } else if ([key isEqualToString:@"minMoney"]) {
        self.amountMin = value;
    } else if ([key isEqualToString:@"maxMoney"]) {
        self.amountMax = value;
    }
}

@end


//
//  ProductListModel.m
//  DSLC
//
//  Created by 马成铭 on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ProductListModel.h"

@implementation ProductListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"annualYield"]) {
        self.productAnnualYield = value;
    } else if ([key isEqualToString:@"period"]) {
        self.productPeriod = value;
    } else if ([key isEqualToString:@"status"]) {
        self.productStatus = value;
    } else if ([key isEqualToString:@"initLimit"]) {
        self.productInitLimit = value;
    }
}

@end

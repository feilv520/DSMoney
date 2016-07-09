//
//  TWORedBagModel.m
//  DSLC
//
//  Created by ios on 16/6/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORedBagModel.h"

@implementation TWORedBagModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"repPacketMoney"]) {
        self.redPacketMoney = value;
    }
}

@end

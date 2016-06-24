//
//  TWOMoneyTeacherList.m
//  DSLC
//
//  Created by ios on 16/6/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMoneyTeacherList.h"

@implementation TWOMoneyTeacherList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end

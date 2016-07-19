//
//  TWOMessageModel.m
//  DSLC
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMessageModel.h"

@implementation TWOMessageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end

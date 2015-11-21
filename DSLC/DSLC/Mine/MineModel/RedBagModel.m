//
//  RedBagModel.m
//  DSLC
//
//  Created by 马成铭 on 15/11/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RedBagModel.h"

@implementation RedBagModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.rpID = value;
    }
}

@end

//
//  BankName.m
//  DSLC
//
//  Created by ios on 15/12/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BankName.h"

@implementation BankName

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.iD = value;
    }
}

@end

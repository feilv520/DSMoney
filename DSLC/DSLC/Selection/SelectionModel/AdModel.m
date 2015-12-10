//
//  AdModel.m
//  DSLC
//
//  Created by 马成铭 on 15/12/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AdModel.h"

@implementation AdModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"Id"]) {
        self.ID = value;
    }
}

@end

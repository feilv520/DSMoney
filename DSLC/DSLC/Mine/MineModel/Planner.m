//
//  Planner.m
//  DSLC
//
//  Created by ios on 15/11/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "Planner.h"

@implementation Planner

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end

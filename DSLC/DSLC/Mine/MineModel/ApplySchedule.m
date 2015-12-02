//
//  ApplySchedule.m
//  DSLC
//
//  Created by ios on 15/12/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ApplySchedule.h"

@implementation ApplySchedule

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.Id = value;
    }
}

@end

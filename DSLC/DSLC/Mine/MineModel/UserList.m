//
//  UserList.m
//  DSLC
//
//  Created by ios on 15/12/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "UserList.h"

@implementation UserList
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"recUserId"]) {
        
        self.recUserId = value;
    }
}
@end

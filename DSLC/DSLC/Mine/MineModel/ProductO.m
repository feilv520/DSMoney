//
//  ProductO.m
//  DSLC
//
//  Created by ios on 15/12/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ProductO.h"

@implementation ProductO
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"productId"]) {
        
        self.idid = value;
    }
}
@end

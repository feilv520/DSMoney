//
//  MessageModel.m
//  DSLC
//
//  Created by 马成铭 on 15/11/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.msgID = value;
    }
}

@end

//
//  NSString+Check.h
//  DSLC
//
//  Created by 马成铭 on 15/11/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validatePassword:(NSString *)password;
+ (BOOL) validateIDCardNumber:(NSString *)IDCardNumber;
+ (BOOL) checkCardNo:(NSString*) cardNo;
//首字母是否为字母
+ (BOOL)pipeizimu:(NSString *)str;
//判断是否都是数字
+ (BOOL)isPureFloat:(NSString *)string;
@end

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
@end

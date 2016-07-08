//
//  NSString+md5String.h
//  DSLC
//
//  Created by 马成铭 on 16/7/8.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5String)

+ ( NSString *)md5String:( NSString *)str;
+ ( NSString *)md5StringNB:( NSString *)str;
+ (NSString *)md5:(NSString *)str;
@end

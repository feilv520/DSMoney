//
//  DES3Util.h
//  lx100-gz
//
//  Created by  柳峰 on 12-10-10.
//  Copyright 2012 http://blog.csdn.net/lyq8479. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DES3Util : NSObject {
    
}

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
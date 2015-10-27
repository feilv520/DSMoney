//
//  FileOfManage.h
//  DSLC
//
//  Created by 马成铭 on 15/10/27.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOfManage : NSObject

// 文件路径
+ (NSString *)PathOfFile;

// 创建plist文件
+ (void)createWithFile;

// 是否存在plist文件
+ (BOOL)ExistOfFile;

@end

//
//  FileOfManage.m
//  DSLC
//
//  Created by 马成铭 on 15/10/27.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FileOfManage.h"

@implementation FileOfManage

// 文件路径
+ (NSString *)PathOfFile:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename = [path stringByAppendingPathComponent:fileName];
    NSLog(@"00000%@",filename);
    return filename;
}

// 创建plist文件
+ (void)createWithFile:(NSString *)fileName{
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:[self PathOfFile:fileName] contents:nil attributes:nil];
}

+ (BOOL)ExistOfFile:(NSString *)fileName{
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isDirExist = [fm fileExistsAtPath:[self PathOfFile:fileName] isDirectory:FALSE];
    return isDirExist;
}

@end

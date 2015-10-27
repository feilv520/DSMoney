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
+ (NSString *)PathOfFile{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"Flag.plist"];
    return filename;
}

// 创建plist文件
+ (void)createWithFile{
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:[self PathOfFile] contents:nil attributes:nil];
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"FlagWithVC",nil];
    [dic writeToFile:[self PathOfFile] atomically:YES];
}

+ (BOOL)ExistOfFile{
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isDirExist = [fm fileExistsAtPath:[self PathOfFile] isDirectory:FALSE];
    return isDirExist;
}

@end
